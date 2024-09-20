/**
 * Created by itaranov on 9/3/15.
 */

function intToTime(x)
{
    var hh = parseInt(x / (60*60));
    var mm = parseInt((x % (60*60)) / 60);
    var ss = parseInt(x % 60);

    return String(mm).concat(":").concat(ss < 10 ? "0" : "").concat(String(ss));
}

function format(str, args) {
    jQuery.each(args, function(k, v) {
        var regEx = new RegExp("\\{" + String(k) + "\\}", "g");
        str = str.replace(regEx, v);
    });

    return str;
}

String.prototype.format = function (arg)
{
    var str = this;
    var regEx = new RegExp("\\{\\}", "g");

    if (typeof arg === 'number') {
        str = str.replace(regEx, String(arg));
    } else if (typeof arg === 'string') {
        str = str.replace(regEx, arg);
    } else {
        jQuery.each(arg, function(k, v) {
            var regEx = new RegExp("\\{" + String(k) + "\\}", "g");
            str = str.replace(regEx, v);
        });
    }

    return str;
};

String.prototype.pad = function (n, c)
{
    var str = this;

    n -= str.length;
    while (n > 0) { str = str.concat("&nbsp;"); --n; }

    return str;
};

UpdateTable = function(data, selector, classes)
{
    var container = $(selector);

    if (container.length != 0)
    {
        container.empty();

        container.append("<table><tr>" +
            jQuery.map(data['columns'], function (value, i) {
                return "<th class='{0}'>{1}</th>".format([classes[i], value]);
            }).join("")
        + "</tr>" +
            jQuery.map(data['values'], function (ivalue) {
                return "<tr>" + jQuery.map(ivalue, function (jvalue, i) {
                    return "<td class='{0}'>{1}</td>".format([classes[i], jvalue]);
             } ).join("") + "</tr>"; } ).join("")
            + "</table>");
    }

    $('#container').masonry();
};

RenderDatabase = function(data, onCreate)
{
    var containerName = "db-cont-" + data.name;
    var container = $("#" + containerName);

    if (container.length == 0)
    {
        container = onCreate(containerName);
    }

    if (container.length != 0)
    {
        container.empty();
//		container.append("<p class='nodata'>No data</p>");

        var isOnline = data.info['Status'].indexOf("ONLINE") > -1;

        var dbInfo = {
            online : isOnline,
            iconColor : isOnline ? 'green' : 'red',
            marker : 'db-color-' + data['name'],
            name : data['name']
        };

        container.append("<h3><img src='db.svg' height='20' width='20'>"
            + "<div id='{marker}' class='color-marker'>&nbsp;</div>&nbsp;Shard {name}</h3>".format(dbInfo));

        container.append("<p>" +
            jQuery.map(data.info, function(value, key) {
                return key.pad(12, "&nbsp;").replace(/ /g, "&nbsp;").concat("&nbsp;:&nbsp;").concat(
                    value.replace(/ /g, "&nbsp;")
                        .replace("*ONLINE", "<span class='good'>online</span>"))
            }).join("<br />") + "</p>");

        var chunkClass = function (chunk) { return ((data['rochunks'].indexOf(chunk) == -1) ? 'chunk' : 'chunk ro'); };

        container.append("<p class='chunks'>".concat(
            jQuery.map(data['chunks'], function(value, key) {
                return "<span class='{cls}'>{name}</span>".format(
                    { "cls" : chunkClass(value), "name" : value })
            }).join(" ")).concat("</p>"));

        this.digest = data['digest'];
    }
};

DatabaseSeries = function(createContainer)
{
    this.names      = [];
    this.changed    = true;
    this.metricData = [];
    this.values     = {};
    this.databaseWidgets = {};
    this.createContainer = createContainer;
    this.updatedWidgets = 0;

    this.colorConstants = [
        "102,0,0",
        "0,102,0",
        "0,0,102",
        "60,179,113",
        "30,144,255",
        "255,153,51",
    ];

    this.color = function(idx, alpha) {
        return 'rgba({0}, {1})'.format([this.colorConstants[idx], String(alpha)]);
    }

    this.update = function(data)
    {
        var self = this;
        this.updatedWidgets = 0;

        this.changed = !(this.names.join("+") === data["databaseNames"].join("+"));

        console.log(data['databases']);

        jQuery.each(data['databases'], function (name, info) {
            if (!(name in self.databaseWidgets) || self.databaseWidgets[name].digest != info['digest']) {
                self.databaseWidgets[name] = new RenderDatabase(info, self.createContainer);
                ++ self.updatedWidgets;
            }
        });

        if (this.changed) {
            this.names = data["databaseNames"];
        }

        jQuery.each(data['databaseNames'], function (i, k) {
            $('#db-color-' + k).css('background-color', self.color(i, 1.0)); } );

        this.data = data["metrics"];
        this.values.sessions = data["sessions"]
    };

    this.updated = function () {
        this.changed = false;
        if (this.updatedWidgets > 0) { $('#container').masonry(); };
    };
};


MetricChart = function(series, elementSelector, metricId)
{
    this.canvas    = $(elementSelector).get(0);
    this.series    = series;
    this.metricId  = metricId;

    this.chart = null;
    this.chartOptions = {datasetFill : false, bezierCurveTension : 0.3, animation:false};
    this.lastDataPoint = 0;
    this.maxPoints = 12;
    this.actualPoints = 0;
    this.metricData = [];

    this.redraw = function()
    {
        if (this.chart !== null) { this.chart.destroy(); this.chart = null; }

        var data = { labels : [], datasets : [] };
        var self = this;

        data.datasets = jQuery.map(this.series.names, function (x, idx) {
            return {
                label: x,
                strokeColor: self.series.color(idx, 0.8),
                pointColor : self.series.color(idx, 1.0),
                pointStrokeColor: "#fff",
                data: []
            };
        });

        var metricId = this.metricId;
        var actualPoints = this.metricData.length;

        this.lastDataPoint = this.metricData[0].t;
        this.metricData.sort(function(a, b) { return a.t - b.t; });

        jQuery.each(this.metricData, function (idx, x) {
            data.labels.push(intToTime(x.t));
            jQuery.each(x[metricId], function (jdx, y) {
                data.datasets[jdx].data.push(y);
            });
        });

        this.chart = new Chart(this.canvas.getContext("2d")).Line(data, this.chartOptions);

        while (actualPoints > this.maxPoints) {
            this.chart.removeData();
            --actualPoints;
        }

        this.actualPoints = actualPoints;
        this.chart.options.animation = true;
    };

    this.update = function()
    {
        /* copy original metric data */
        this.metricData = this.series.data.slice(0);

        if (this.metricData.length == 0) { return; }

        if (this.chart == null || this.series.changed) {
            this.redraw();
        } else {
            var self = this;

            this.metricData = jQuery.grep(this.metricData, function(x) {
                return x.t > self.lastDataPoint;
            });

            if (this.metricData.length == 0)
            {
                this.metricData = this.series.data.slice(0);
                return this.redraw();
            }

            this.lastDataPoint = this.metricData[0].t;
            this.metricData.sort(function(a, b) { return a.t - b.t; });

            var metricId = this.metricId;

            jQuery.each(this.metricData, function (idx, x) {
                self.chart.addData(x[metricId], intToTime(x.t));
                ++self.actualPoints;

                while (self.actualPoints > self.maxPoints) {
                    self.chart.removeData();
                    --self.actualPoints;
                }
            });
        }
    };
};

SeriesItemChart = function(series, elementSelector, metricId, name)
{
    this.canvas     = $(elementSelector).get(0);
    this.series     = series;
    this.metricId   = metricId;
    this.metricName = name;

    this.chart = null;

    this.chartOptions = {
        barStrokeWidth    : 1,
        barDatasetSpacing : 3,
        showTooltips      : false,
        scaleOverride     : true,
        scaleSteps        : 9,
        scaleStepWidth    : 4,
        animation         : false
    };

    this.data = [];

    this.redraw = function ()
    {
        if (this.chart !== null) { this.chart.destroy(); this.chart = null; }

        var data = { labels : [this.metricName], datasets : [] };
        var self = this;

        data.datasets = jQuery.map(this.series.names, function (x, i) {
            return {
                label       : x,
                fillColor   : self.series.color(i, 0.8), // "rgba(" + colorList[i] + ", 0.8)",
                strokeColor : self.series.color(i, 1.0),
                data        : [self.data[i]]
            };
        });

        this.chart = new Chart(this.canvas.getContext("2d")).HorizontalBar(data, this.chartOptions);
        this.chart.options.animation = true;
    };

    this.update = function ()
    {
        this.data = this.series.values[this.metricId].slice(0);
        var self = this;

        if (this.chart == null || this.series.changed) {
            this.redraw();
        } else {
            jQuery.each(this.series.names, function (i) {
                self.chart.datasets[i].bars[0].value = self.data[i];
            });

            this.chart.update();
        }
    };
};

PartitionData = function ()
{
    this.labels = [];
    this.values = [];
    this.data   = null;

    this.update = function(data)
    {
        var self = this;

        this.labels = [];
        this.values = [];

        jQuery.each(data, function (idx, x) {
            self.labels.push(idx.replace(/[A-Z]*_P/, ''));
            self.values.push(x);
        });
    };

    this.updated = function () { }
};

DataItemChart = function (series, elementSelector, name)
{
    this.canvas     = $(elementSelector).get(0);
    this.series     = series;
    this.metricName = name;

    this.chart  = null;
    this.labels = [];

    this.chartOptions = {
        barStrokeWidth    : 1,
        barDatasetSpacing : 3,
        animation         : false
    };

    this.redraw = function ()
    {
        if (this.chart !== null) { this.chart.destroy(); this.chart = null; }

        this.chart = new Chart(this.canvas.getContext("2d")).Bar({
            labels: this.series.labels.slice(0),
            datasets: [{
                label:       "Count",
                fillColor:   "rgba(255, 211, 155, 0.8)",
                strokeColor: "rgba(240, 191, 125, 1)",
                data: this.series.values.slice(0)
            }]
        }, this.chartOptions);

        this.labels = this.series.labels.slice(0);
        this.chart.options.animation = true;
    };

    this.update = function()
    {
        var self = this;

        if (this.chart == null) { this.redraw(); }

        jQuery.each(this.series.labels, function (idx, x) {
            var i = self.labels.indexOf(x);

            if (i == -1) {
                self.labels.push(x);
                self.chart.addData([self.series.values[idx]], x);
            } else {
                self.chart.datasets[0].bars[i].value = self.series.values[idx];
            }
        });

        this.chart.update();
    };
};

