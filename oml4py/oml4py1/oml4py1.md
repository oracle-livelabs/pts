# Run OML4Py notebook part 1

## Introduction

Oracle Machine Learning for Python (OML4Py) enables the open source Python programming language and environment to operate on database data at scale. Python users can run Python commands and scripts for statistical analysis and machine learning on data stored in Oracle Database.

With OML4Py, you can do the following:

* Use a wide range of in-database machines learning algorithms
* Minimize data movement
* Leverage Oracle Database as a high performance compute engine for data exploration and preparation
* Use AutoML for automatic algorithm selection, feature selection, and model tuning
* Execute user-defined Python functions in non-parallel, data-parallel, and task-parallel fashion

In this workshop, you have a dataset representing 15k customers of an insurance company. Each customer has around 30 attributes, and our goal is to train our database to predict customers life-time value (LTV), or to classify them in predefined classes based on this predicted value.

In marketing, [life-time value (LTV)](https://en.wikipedia.org/wiki/Customer_lifetime_value) is a prognostication of the net profit contributed to the whole future relationship with a customer.

Estimated Time: 2 hours 50 min

Watch the video below for a quick walk through of the lab.

[](youtube:u1jGQJLdaZE)

### Objectives

In this lab, you will:
* Connect OML4Py Jupyter Notebook to Oracle Database 21c, to prepare and explore data;
* Perform **multi-label and binary classification** using Neural Network, Decision Tree algorithms;
* Use Generalized Linear Model **regression** to predict numeric values;
* Implement K-Means algorithm to carry out customer **clustering** for marketing segmentation;
* Use Attribute Importance to rank customer attributes, and Singular Value Decomposition for feature extraction, in order to simplify data models;
* Use Automated Machine Learning Algorithm Selection, Feature Selection, Model Tuning, and Model Selection.

Optionally (part 2), you can:
* Identify patterns of association using Association Rules;
* Implement Expectation Maximization and K-Means algorithms for customer clustering;
* Practice Naive Bayes, Random Forest and Support Vector Machine algorithms for classification;
* Sentiment Analysis on free text customer reviews and comments using binary classification.

### Prerequisites

* Oracle Database 21c installed on-premise;
* Python, Jupyter Notebook, and required libraries.

## Task 1: Prepare and explore data

1. On Jupyter Notebook dashboard, click **New** > **Python 3** to create a new notebook.

2. Click **File** > **Rename**, and name it **LabNotebook[ABC]** where **[ABC]** are your initials.

3. Copy the code lines and paste them in the notebook current cell. Click **Run** to execute the code. Wait until you get a number in front of the cell, meaning the execution is complete. The first block of Python code retrieves the host name and the database service name from your environment.

    ```python
    <copy>
    # Run the following commands to get your hostname and pluggable database service name
    import os
    print('Hostname: ',os.uname()[1])
    stream = os.popen('lsnrctl status | grep mlpdb1')
    print('Database service: ',stream.read())
    </copy>
    ```


4. Connect to your Oracle 21c Pluggable Database, and check connectivity. Verify and change the `host` and `service_name` values with the actual host name and database service name you retrieved in the previous step.

    ```python
    <copy>
    import oml
    import pandas as pd
    oml.connect(user="oml_user", password="MLlearnPTS#21_",
                host="<YOUR-HOSTNAME>", port=1521,
                service_name="<YOUR-SERVICE>",
                automl=True)
    oml.isconnected()
    </copy>
    ```

5. Open a cursor and verify database version.

    ```python
    <copy>
    cr = oml.cursor()
    conn = cr.connection
    print("Database version:", conn.version)
    </copy>
    ```

6. Retrieve user tables from the database schema.

    ```python
    <copy>
    cr.execute("select table_name, num_rows from user_tables order by 1").fetchall()
    </copy>
    ```

    > **Note** :  When you execute a query using an `oml.cursor`, the result is a Python list.

7. It is always a good practice to close the cursor once your transaction is completed.

    ```python
    <copy>
    cr.close()
    </copy>
    ```

8. You can use external data sources for educational purposes.

    ```python
    <copy>
    from pydataset import data
    data()
    </copy>
    ```

9. Filter properties and methods list using pattern `'*Ins**'` and wildcard.

    ```python
    <copy>
    import fnmatch
    load_list = fnmatch.filter(data().dataset_id, '*Ins*')
    print(load_list)
    </copy>
    ```

10. Load Insurance dataset as a Pandas data frame.

    ```python
    <copy>
    claims_df = data('Insurance')
    claims_df
    </copy>
    ```

11. Create a table in the database schema and return an OML data frame (`oml.DataFrame`) object that is a proxy for the table.

    ```python
    <copy>
    try:
       oml.drop('CUST_INSUR_CLAIMS')
    except:
       pass
    oml_claims = oml.create(claims_df, table = 'CUST_INSUR_CLAIMS')
    </copy>
    ```

    > **Note** :  Notice you try to drop `CUST_INSUR_CLAIMS` table before creating it, just to make sure it doesn't exist already and you get an error.

12. Refresh `OML_USER` tables in SQL Developer, and verify the data in new table `CUST_INSUR_CLAIMS`.

    ```python
    <copy>
    select * from CUST_INSUR_CLAIMS;
    </copy>
    ```

13. Check the type of `claims_df` object.

    ```python
    <copy>
    type(claims_df)
    </copy>
    ```

14. Check the type of `oml_claims` object.

    ```python
    <copy>
    type(oml_claims)
    </copy>
    ```

    > **Note** :  It is recommended to verify the type every time you create a new Python object. It is also recommended to return a the list of attributes of the object using `dir(object_name)` function.

15. Check the columns of `oml_claims` data frame, using OML data frame `columns` attribute.

    ```python
    <copy>
    oml_claims.columns
    </copy>
    ```

16. Display the values in `oml_claims` data frame. As it has 15k records, the list is truncated.

    ```python
    <copy>
    oml_claims
    </copy>
    ```

17. Retrieve `OML_USER` tables column details and close the cursor when finished.

    ```python
    <copy>
    cr = oml.cursor()
    col_list = cr.execute("select table_name, column_name, data_type, data_length \
                         from user_tab_cols \
                         where table_name like 'CUST_%' \
                         order by 1,2").fetchall()
    cr.close()
    col_list
    </copy>
    ```

18. Check the type of `col_list` object.

    ```python
    <copy>
    type(col_list)
    </copy>
    ```

19. Check the type of one element in `col_list` object.

    ```python
    <copy>
    type(('CUST_INSUR_LTV', 'T_AMOUNT_AUTOM_PAYMENTS', 'NUMBER', 22))
    </copy>
    ```

20. Create a Pandas data frame using records from `col_list` object.

    ```python
    <copy>
    col_df = pd.DataFrame(col_list, columns = ['TABLE_NAME', 'COLUMN_NAME', 'DATA_TYPE', 'DATA_LENGTH'])
    col_df
    </copy>
    ```

21. Create a new OML data frame object that contains two columns from `oml_claims` object, filtered by `Age`.

    ```python
    <copy>
    oml_claims_24 = oml_claims[oml_claims["Age"] == '<25',
                               ["Holders", "Claims"]]
    oml_claims_24
    </copy>
    ```

22. Return the sum of the values, representing the total number of claims for drivers under 25.

    ```python
    <copy>
    oml_claims_24.sum()
    </copy>
    ```

23. Calculate risk factor for drivers under 25, as number of claims divided by the number of holders.

    ```python
    <copy>
    oml_claims_24.sum().Claims/oml_claims_24.sum().Holders
    </copy>
    ```

24. Generate a Pandas data frame from a database table. `CUST_INSUR_LTV` is the table you will use during the entire workshop, containing insurance customers data.

    ```python
    <copy>
    cust_df = oml.sync(table = "CUST_INSUR_LTV").pull()
    type(cust_df)
    </copy>
    ```

25. Display the first records in `cust_df` Pandas data frame, by default 10.

    ```python
    <copy>
    cust_df.head()
    </copy>
    ```

26. Generate an OML data frame from your database table.

    ```python
    <copy>
    oml_cust = oml.sync(table = 'CUST_INSUR_LTV')
    type(oml_cust)
    </copy>
    ```

27. Display the first records in `oml_cust` OML data frame, by default 10.

    ```python
    <copy>
    oml_cust.head()
    </copy>
    ```

28. Life-time value (LTV) is stored in `LTV` column, and predefined classes based on this value are stored in `LTV_BIN` column. These classes have been defined by a human operator. Keep this in mind when you are testing clustering algorithms for market segmentation, the machine doesn't have to follow same limits as the ones specified by the business user.

    ```python
    <copy>
    classes = oml.sync(query = 'select LTV_BIN, min(LTV), max(LTV) \
                                from CUST_INSUR_LTV group by LTV_BIN order by 2')
    classes
    </copy>
    ```

    > **Note** : As you can see, our data is pre-labeled. However, you will drop the labels you don't need during training phase, depending on the algorithm. You will drop all labels during testing phase, and verify predicted labels with the pre-label information to check your model accuracy.

29. Plot the distribution of customers by LTV. The most common approach to visualizing a distribution is the histogram.

    ```python
    <copy>
    import matplotlib.pyplot as plt
    oml.graphics.hist(oml_cust['LTV'], 'auto', color='orange',
                      linestyle='solid', edgecolor='white')
    plt.title('Customers distribution by LTV')
    plt.ylabel('Customers')
    plt.xlabel('LTV')
    </copy>
    ```


## Task 2: Perform customer classification using a Neural Network

Neural Network (NN) algorithms can be used for regression and classification machine learning functions. There are two types of classification:

- Binary classification refers to predicting one of two classes for each customer case. E.g. if a customer will buy insurance or not: Yes, No.
- Multi-label classification refers to predicting one of more than two classes for each customer. E.g. what size is a customer: Low, Medium, Large, Very Large.

An artificial neural network is composed of a large number of interconnected neurons which exchange messages between each other to solve specific problems. They learn by examples and tune the weights of the connections among the neurons during the learning process.

> **Note** : For more information, visit [Neural Network](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/neural-network.html#GUID-C45971D9-A874-4546-A0EC-1FF25B229E2B) documentation.

At this step, you will build, test, and tune a neural network that can classify your customers in four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*). You will test both types of classification.

Watch the video below for a quick walk through of the lab.

[](youtube:VT2R3zJ2A2Q)

1. Generate an OML data frame from your database table.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data.

    ```python
    <copy>
    ltv_dat = oml_cust.split()
    [split.shape for split in ltv_dat]
    </copy>
    ```

3. Create training data and test data.

    ```python
    <copy>
    train_x = ltv_dat[0].drop('LTV_BIN')
    train_y = ltv_dat[0]['LTV_BIN']
    test_ltv = ltv_dat[1]
    </copy>
    ```

4. Create a NN model object.

    ```python
    <copy>
    nn_mod = oml.nn(nnet_hidden_layers = 1,
                    nnet_activations= "'NNET_ACTIVATIONS_LOG_SIG'",
                    NNET_NODES_PER_LAYER= '30')
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Neural Network](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-7793F608-2719-45EA-87F9-6F246BA800D4) documentation.

    > **Note** : To understand this model, visit the [Neural Network](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/neural-network.html#GUID-27FE0680-91A9-4F44-B69C-134E3D3BEEC8) page in OML user guide.

5. Fit the NN model according to the training data and parameter settings.

    ```python
    <copy>
    nn_mod = nn_mod.fit(train_x, train_y)
    </copy>
    ```

6. Show details of the model. Did your model converge? If yes, after how many iterations?

    ```python
    <copy>
    nn_mod
    </copy>
    ```

7. Use the model to make predictions on test data.

    ```python
    <copy>
    nn_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']]).head(25)
    </copy>
    ```

8. Return the prediction probability.

    ```python
    <copy>
    nn_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']],
                   proba = True).head(25)
    </copy>
    ```

9. Return mean accuracy for classification. How accurate is your model?

    ```python
    <copy>
    nn_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

10. Change the setting parameter and refit the model. After how many iterations did this model converge?

    ```python
    <copy>
    new_setting = {'NNET_NODES_PER_LAYER': '50'}
    nn_mod.set_params(**new_setting).fit(train_x, train_y)
    </copy>
    ```

11. Return new mean accuracy for classification. How is the new accuracy compared to the previous one?

    ```python
    <copy>
    nn_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

12. Export the NN model as a serialized model to a new table named `NN_MODEL` in the database.

    ```python
    <copy>
    try:
       oml.drop('NN_MODEL')
    except:
       pass
    nn_export = nn_mod.export_sermodel(table='NN_MODEL')
    type(nn_export)
    </copy>
    ```

13. Show the first 10 characters of the BLOB content from the serialized model export.

    ```python
    <copy>
    nn_export.pull()[0][1:10]
    </copy>
    ```

14. You can use a NN model for Binary Classification. In this case you can predict if customer will buy or not the insurance, column `BUY_INSURANCE` in the data set. Re-generate an OML data frame.

    ```python
    <copy>
    # Use Neural Network for Binary Classification
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust.head()
    </copy>
    ```

15. Split the data set and create training and test data.

    ```python
    <copy>
    ltv_dat = oml_cust.split()
    train_x = ltv_dat[0].drop('BUY_INSURANCE')
    train_y = ltv_dat[0]['BUY_INSURANCE']
    test_ltv = ltv_dat[1]
    </copy>
    ```

16. Create a NN model object, with new settings and refit the model.

    ```python
    <copy>
    setting = {'nnet_hidden_layers': 1,
               'nnet_activations': 'NNET_ACTIVATIONS_LOG_SIG',
               'NNET_NODES_PER_LAYER': '30'}
    nn_mod.set_params(**setting).fit(train_x, train_y)
    </copy>
    ```

17. Use the model to make predictions on test data. This time it predicts if customers will buy on not insurance.

    ```python
    <copy>
    nn_mod.predict(test_ltv.drop('BUY_INSURANCE'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','BUY_INSURANCE']]).head(25)
    </copy>
    ```

18. Return mean accuracy for the binary classification. How accurate is your model? Can you improve this accuracy?

    ```python
    <copy>
    nn_mod.score(test_ltv.drop('BUY_INSURANCE'), test_ltv[:, ['BUY_INSURANCE']])
    </copy>
    ```


## Task 3: Classification model using Decision Tree algorithm

Decision Tree (DT) is a supervised machine learning algorithm used for classifying data. In some applications of Oracle Machine Learning, the ability to explain the reason for a decision can be crucial. Decision trees generate rules. A rule is a conditional statement that can be understood by humans and used within a database to identify a set of records.

> **Note** : For more information on this algorithm, visit [Decision Tree](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/decision-tree.html#GUID-14DE1A88-220F-44F0-9AC8-77CA844D4A63) documentation.

In this example, you will not only classify your customers in four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*), but you will also retrieve the rules (conditions) that are behind the customers classification.

Watch the video below for a quick walk through of the lab.

[](youtube:FSV_UDp_QNs)

1. Create the OML data frame for this step. Drop `LTV` column as you will use only the `LTV_BIN` classes for the predicted value.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Verify the shape of the OML data frame.

    ```python
    <copy>
    oml_cust.shape
    </copy>
    ```

3. Split the data set into training and test data. Use 80% for train and 20% for test ratio.

    ```python
    <copy>
    ltv_dat = oml_cust.split(ratio=(.8, .2))
    [split.shape for split in ltv_dat]
    </copy>
    ```

4. Create training data and test data.

    ```python
    <copy>
    train_x = ltv_dat[0].drop('LTV_BIN')
    train_y = ltv_dat[0]['LTV_BIN']
    test_ltv = ltv_dat[1]
    </copy>
    ```

5. Verify the four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*) in your dataset.

    ```python
    <copy>
    cr = oml.cursor()
    cr.execute("select unique LTV_BIN from CUST_INSUR_LTV order by 1").fetchall()
    </copy>
    ```

6. Close the cursor.

    ```python
    <copy>
    cr.close()
    </copy>
    ```

7. Create a cost matrix table in the database. A cost matrix is a mechanism for influencing the decision making of a model. In this case, the cost matrix will cause the model to minimize costly misclassifications.

    ```python
    <copy>
    try:
       oml.drop('LTV_COST_MATRIX')
    except:
       pass
    cost_matrix = [['LOW', 'LOW', 0],
                   ['LOW', 'MEDIUM', 0.3],
                   ['LOW', 'HIGH', 0.3],
                   ['LOW', 'VERY HIGH', 0.4],
                   ['MEDIUM', 'LOW', 0.4],
                   ['MEDIUM', 'MEDIUM', 0],
                   ['MEDIUM', 'HIGH', 0.3],
                   ['MEDIUM', 'VERY HIGH', 0.3],
                   ['HIGH', 'LOW', 0.5],
                   ['HIGH', 'MEDIUM', 0.3],
                   ['HIGH', 'HIGH', 0],
                   ['HIGH', 'VERY HIGH', 0.2],
                   ['VERY HIGH', 'LOW', 0.6],
                   ['VERY HIGH', 'MEDIUM', 0.3],
                   ['VERY HIGH', 'HIGH', 0.1],
                   ['VERY HIGH', 'VERY HIGH', 0]]
    cost_matrix = oml.create( pd.DataFrame(cost_matrix,
                              columns = ['ACTUAL_TARGET_VALUE',
                                         'PREDICTED_TARGET_VALUE',
                                         'COST']),
                              table = 'LTV_COST_MATRIX')
    </copy>
    ```

    > **Note** : For more information, visit [Cost Matrix Table](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-CF6EB584-8FE9-44F5-BAC0-0751DC094CCE__CACBEFFJ) documentation.


8. Specify algorithm settings.

    ```python
    <copy>
    setting = {'TREE_TERM_MAX_DEPTH':'8'}
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Decision Tree](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-03435110-D723-42FD-B4EA-39C86A039566) documentation.

9. Create a DT model object.

    ```python
    <copy>
    dt_mod = oml.dt(**setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Decision Tree](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/decision-tree.html#GUID-C95E5C76-1778-44C2-A7E3-8BC6433BFF35) page in OML user guide.

10. Fit the DT model according to the training data and parameter settings.

    ```python
    <copy>
    dt_mod.fit(train_x, train_y, cost_matrix = cost_matrix)
    </copy>
    ```

11. Use the model to make predictions on the test data.

    ```python
    <copy>
    predict_dat = dt_mod.predict(test_ltv.drop('LTV_BIN'),
                                 supplemental_cols = test_ltv[:, ['CUST_ID','LAST','FIRST','LTV_BIN']])
    predict_dat.sort_values('CUST_ID')
    </copy>
    ```

12. Confusion matrix is a technique for summarizing the performance of a classification model. This matrix shows the number of customers pre-labeled with `LTV_BIN` value and predicted as `PREDICTION` value in `count(CUST_ID)_(PREDICTION)` columns.

    ```python
    <copy>
    predict_dat[['LTV_BIN','PREDICTION',
                 'CUST_ID']].pivot_table('LTV_BIN', 'PREDICTION',
                                             aggfunc = oml.DataFrame.count)
    </copy>
    ```

13. Show only customers with wrong predictions.

    ```python
    <copy>
    test_predict = test_ltv[['CUST_ID','LAST','FIRST',
                             'LTV_BIN']].merge(other = predict_dat[['CUST_ID',
                                                                    'PREDICTION']],
                                                       on="CUST_ID")
    test_predict[test_predict['LTV_BIN_l'] !=
                 test_predict['PREDICTION_r']].sort_values('CUST_ID')
    </copy>
    ```

14. Make predictions and return the probability. DT model returns prediction probability if `proba` parameter is `True`.

    ```python
    <copy>
    predict_dat = dt_mod.predict(test_ltv.drop('LTV_BIN'),
                                 supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                                  'FIRST','LTV_BIN']],
                                 proba = True)
    predict_dat.sort_values('CUST_ID')
    </copy>
    ```

15. Show only customers with wrong predictions and the probability.

    ```python
    <copy>
    test_predict = test_ltv[['CUST_ID','LAST',
                             'FIRST','LTV_BIN']].merge(other = predict_dat[['CUST_ID','PREDICTION',
                                                                            'PROBABILITY']],
                                                       on="CUST_ID")
    test_predict[test_predict['LTV_BIN_l'] != test_predict['PREDICTION_r']].sort_values('PROBABILITY_r')
    </copy>
    ```

16. Calculate the DT model score. DT model `score` attribute returns the mean accuracy.

    ```python
    <copy>
    dt_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

17. Reset `TREE_TERM_MAX_DEPTH` and refit model. This setting represents the maximum number of nodes between the root and any leaf node, including the leaf node. More nodes means longer time to train the DT model. You may grab a coffee until this step is completed.

    ```python
    <copy>
    dt_mod.set_params(TREE_TERM_MAX_DEPTH = '9').fit(train_x, train_y, cost_matrix = cost_matrix)
    </copy>
    ```

18. Re-calculate the model score. How much did it improve? You can decide if it is worth the time spent.

    ```python
    <copy>
    dt_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

19. The good thing is that once you have a great model, it can be exported and reused, even to other databases, e.g. Oracle Autonomous Database. Export serialized model to a table.


    ```python
    <copy>
    dt_export = dt_mod.export_sermodel(table='dt_sermod')
    </copy>
    ```

20. Your DT model is exported as a binary object.

    ```python
    <copy>
    type(dt_export)
    </copy>
    ```

21. Show the first 100 characters of the BLOB content from the model export.

    ```python
    <copy>
    dt_export.pull()[0][1:100]
    </copy>
    ```


## Task 4: Predict LTV values using Generalized Linear Model regression

Generalized Linear Model (GLM) is a statistical technique used for linear modeling. Oracle Machine Learning supports GLM for regression and binary classification. Regression is a supervised learning technique used to a predict continuous response target value based on independent predictors.

> **Note** : For more information on this algorithm, visit [Generalized Linear Model](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/generalized-linear-model.html#GUID-5E59530F-EBD9-414E-8C8B-63F8079772CE) documentation.

In your case, the independent predictors are customer attributes, and the response target value is the customer life-time value.

Watch the video below for a quick walk through of the lab.

[](youtube:ZsQ2MBP9TrA)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV_BIN')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data, using default ratio.

    ```python
    <copy>
    ltv_dat = oml_cust.split()
    [split.shape for split in ltv_dat]
    </copy>
    ```

3. Create training data and test data.

    ```python
    <copy>
    train_x = ltv_dat[0].drop('LTV')
    train_y = ltv_dat[0]['LTV']
    test_ltv = ltv_dat[1]
    [frame.shape for frame in (train_x, train_y, test_ltv)]
    </copy>
    ```

4. Specify settings.

    ```python
    <copy>
    setting = {'GLMS_SOLVER': 'dbms_data_mining.GLMS_SOLVER_SGD'}
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Generalized Linear Models](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-4E3665B9-B1C2-4F6B-AB69-A7F353C70F5C) documentation.

5. Create a GLM model object.

    ```python
    <copy>
    glm_mod = oml.glm('REGRESSION', **setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Generalized Linear Models](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/general-linearized-model.html#GUID-4464A453-60F0-4751-B231-91BC5708D1F8) page in OML user guide.

6. Fit the GLM model according to the training data and parameter settings. The name of a column that contains unique case identifiers is used for `case_id` parameter.

    ```python
    <copy>
    glm_mod = glm_mod.fit(train_x, train_y, case_id = 'CUST_ID')
    </copy>
    ```

7. Show the model details.

    ```python
    <copy>
    glm_mod
    </copy>
    ```

8. Check the value of `converged` attribute.

    ```python
    <copy>
    glm_mod.converged
    </copy>
    ```

9. Convergence means the optimal solution has been reached and the iterations of the optimization has come to an end. Can you make predictions if `converged` attribute is `False`?

10. Specify new settings.

    ```python
    <copy>
    setting = {'GLMS_SOLVER': 'dbms_data_mining.GLMS_SOLVER_CHOL'}
    </copy>
    ```

11. Recreate a GLM model object with new settings.

    ```python
    <copy>
    glm_mod = oml.glm('REGRESSION', **setting)
    </copy>
    ```

12. Refit the GLM model according to the training data and parameter settings.

    ```python
    <copy>
    glm_mod = glm_mod.fit(train_x, train_y, case_id = 'CUST_ID')
    </copy>
    ```

13. Recheck the value of `converged` attribute.

    ```python
    <copy>
    glm_mod.converged
    </copy>
    ```

14. Use the model to make predictions on the test data. How are the `PREDICTION` values compared to the exact `LTV` values?

    ```python
    <copy>
    glm_mod.predict(test_ltv.drop('LTV'),
                    supplemental_cols = test_ltv[:, ['CUST_ID','LAST','FIRST','LTV']])
    </copy>
    ```

15. Return the prediction probability.

    ```python
    <copy>
    glm_mod.predict(test_ltv.drop('LTV'),
                    supplemental_cols = test_ltv[:, ['CUST_ID','LAST','FIRST','LTV']],
                    proba = True)
    </copy>
    ```

16. How far are predicted values from the pre-labeled `LTV` values you have in the dataset? Create an OML data frame to investigate.

    ```python
    <copy>
    # Create a new OML data frame with label values and predictions
    predictions = glm_mod.predict(test_ltv.drop('LTV'),
                    supplemental_cols = test_ltv[:, ['LTV']])
    predictions
    </copy>
    ```

17. Calculate the differences between pre-labeled `LTV` and predicted `LTV` values.

    ```python
    <copy>
    diff = (predictions['LTV']-predictions['PREDICTION'])
    diff
    </copy>
    ```

18. Concatenate OML data frame with resulted differences.

    ```python
    <copy>
    predictions.rename({'LTV':'LABEL_LTV'})
    ltv_diff = predictions.concat(diff).rename({'LTV':'LTV_DIFFERENCE'})
    ltv_diff
    </copy>
    ```

19. Plot the prediction error values.

    ```python
    <copy>
    import matplotlib.pyplot as plt
    plt.stem(ltv_diff.pull()[['LABEL_LTV']],
             ltv_diff.pull()[['LTV_DIFFERENCE']], 'b.')
    plt.xlabel('Label LTV value')
    plt.ylabel('LTV difference')
    plt.title('Prediction error from prelabeled LTV')
    plt.show()
    </copy>
    ```


## Task 5: Discover natural groupings with K-Means clustering

Oracle Machine Learning supports enhanced k-Means (KM) clustering algorithm. The KM algorithm is a distance-based clustering algorithm that partitions the data into a specified number of clusters. It relies on a distance function to measure the similarity between cases. Cases are assigned to the nearest cluster according to the distance function used.

> **Note** : For more information on this algorithm, visit [k-Means](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/k-means.html#GUID-AA5D4D4E-936F-474A-8919-5E7FF5EE69B1) documentation.

You will group customers in four clusters. KM algorithm is more appropriate for data sets with a low number of attributes. For this reason, you will reduce the training and test data to just one dimension, customer life-time value.

Watch the video below for a quick walk through of the lab.

[](youtube:tx9yKjutc0M)

1. Create training and test data. Use only `CUST_ID` column that contains unique case identifiers, and `LTV` column that contains customer life-time values.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust_one = oml_cust[['CUST_ID','LTV']]
    oml_cust_one.head()
    </copy>
    ```

2. Left merge the `oml_cust` full data set to verify predefined classes stored in `LTV_BIN` column to the reduced data set called `oml_cust_one`.

    ```python
    <copy>
    oml_cust_one.merge(other=oml_cust[['CUST_ID', 'LTV_BIN']], on="CUST_ID")
    </copy>
    ```

3. Split the data set and create training and test data.

    ```python
    <copy>
    ltv_dat = oml_cust_one.split()
    train_ltv = ltv_dat[0]
    test_ltv = ltv_dat[1]
    [frame.shape for frame in (train_ltv, test_ltv)]
    </copy>
    ```

4. Specify settings.

    ```python
    <copy>
    setting = {'kmns_iterations': 20}
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: k-Means](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-7010593E-C323-4DFC-8468-D85CE41A0C3C) documentation.

5. Create a KM model object and fit it according to the training data and parameter settings. `n_clusters` parameter specifies the number of clusters.

    ```python
    <copy>
    km_mod = oml.km(n_clusters = 4, **setting).fit(train_ltv, case_id = 'CUST_ID')
    </copy>
    ```

    > **Note** : To understand this model, visit the [k-Means](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/k-means.html#GUID-7909D96B-D3B9-411B-BAD5-96DAFAF06B42) page in OML user guide.

6. Show KM model details. Did your model converge?

    ```python
    <copy>
    km_mod
    </copy>
    ```

7. Use the model to cluster the test data.

    ```python
    <copy>
    predictions = km_mod.predict(test_ltv,
                     supplemental_cols = test_ltv[:, ['CUST_ID', 'LTV']])
    predictions
    </copy>
    ```

8. Left merge the `oml_cust` full data set to view if there is a connection between the four clusters and the predefined classes stored in `LTV_BIN` column.

    ```python
    <copy>
    km_mod.predict(test_ltv,
                   supplemental_cols = test_ltv[:,
                           ['CUST_ID']]).merge(other=oml_cust[['CUST_ID',
                                                         'LTV_BIN']], on="CUST_ID")
    </copy>
    ```

9. Build a summary to count cluster members grouped by life-time value.

    ```python
    <copy>
    km_mod.predict(test_ltv,
       supplemental_cols = test_ltv[:,
             ['CUST_ID']]).merge(other=oml_cust[['CUST_ID',
                            'LTV_BIN']], on="CUST_ID").crosstab('LTV_BIN_r',
                                     'CLUSTER_ID_l').sort_values(by = ['CLUSTER_ID_l','count'])
    </copy>
    ```

10. What is the relationship between the four clusters discovered by k-Means clustering algorithm and the long-term values?

    ```python
    <copy>
    import matplotlib.pyplot as plt
    plt.rcParams["figure.figsize"] = (8,10)
    plt.plot(predictions[predictions['CLUSTER_ID'] == 3].pull()[['CLUSTER_ID']].replace({3:1}),
             predictions[predictions['CLUSTER_ID'] == 3].pull()[['LTV']], 'ro',
             predictions[predictions['CLUSTER_ID'] == 5].pull()[['CLUSTER_ID']].replace({5:2}),
             predictions[predictions['CLUSTER_ID'] == 5].pull()[['LTV']], 'go',
             predictions[predictions['CLUSTER_ID'] == 6].pull()[['CLUSTER_ID']].replace({6:3}),
             predictions[predictions['CLUSTER_ID'] == 6].pull()[['LTV']], 'bo',
             predictions[predictions['CLUSTER_ID'] == 7].pull()[['CLUSTER_ID']].replace({7:4}),
             predictions[predictions['CLUSTER_ID'] == 7].pull()[['LTV']], 'mo', alpha=0.15)
    plt.xlabel('Cluster 3-red, 5-green, 6-blue, 7-magenta')
    plt.ylabel('LTV')
    plt.show()
    </copy>
    ```

11. Calculate the score value based on the test data.

    ```python
    <copy>
    km_mod.score(test_ltv)
    </copy>
    ```


## Task 6: Rank customer attributes with Attribute Importance

Oracle Machine Learning supports the Attribute Importance (AI) machine learning function, which ranks attributes according to their importance. Attribute importance does not actually select the features, but ranks them as to their relevance to predicting the result. It is up to the user to review the ranked features and create a data set to include the desired features.

> **Note** : For more information, visit [About Feature Selection and Attribute Importance](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/feature-selection.html#GUID-FE2DFE18-670E-4E1A-83A8-5C67CA4D8564) documentation.

In this example, you will use the entire data set, however you will drop `LTV` column. This column represents the exact numeric value of your customers LTV, and you already know there is a direct relationship between this column and the customer class represented in `LTV_BIN` column, so LTV value cannot be considered an attribute.

Watch the video below for a quick walk through of the lab.

[](youtube:K88tfKgNPjI)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data. Default 70% train, 30% test. `train_x` are the customer features, and `train_y` specifies the label for each customer, in this case `LTV_BIN` value.

    ```python
    <copy>
    dat = oml_cust.split()
    train_x = dat[0].drop('LTV_BIN')
    train_y = dat[0]['LTV_BIN']
    test_dat = dat[1]
    </copy>
    ```

3. Verify features data frame shape, number or rows and columns.

    ```python
    <copy>
    train_x.shape
    </copy>
    ```

4. Verify test data frame shape. Why are they different?

    ```python
    <copy>
    test_dat.shape
    </copy>
    ```

5. Specify model settings.

    ```python
    <copy>
    setting = {'ODMS_SAMPLING':'ODMS_SAMPLING_DISABLE'}
    </copy>
    ```

    > **Note** : For the complete list of settings, check the [`DBMS_DATA_MINING` — Global Settings](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-24047A09-0542-4870-91D8-329F28B0ED75) table.

6. Create an AI model object.

    ```python
    <copy>
    ai_mod = oml.ai(**setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Attribute Importance](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/attribute-importance.html#GUID-01F5EB3D-68C2-4EF4-A1BB-AF4320A0246A) page in OML user guide.

7. Fit the AI model according to the training data and parameter settings.

    ```python
    <copy>
    ai_mod = ai_mod.fit(train_x, train_y)
    </copy>
    ```

8. Show the model details.

    ```python
    <copy>
    ai_mod
    </copy>
    ```

9. What rank does it specify for the marital status feature? Is this feature important enough as you considered in the previous step?

    ```
    MARITAL_STATUS    importance: 0.189213     rank: 7
    ```


## Task 7: Perform feature extraction using Singular Value Decomposition

Singular Value Decomposition (SVD) is an unsupervised algorithm for feature extraction. SVD is an orthogonal linear transformation that is optimal at capturing the underlying variance of the data. This property is very useful for reducing the dimensionality of high-dimensional data and for supporting meaningful data visualizations.

> **Note** : For more information, visit [Singular Value Decomposition](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/singular-value-decomposition.html#GUID-703B237F-D9C5-4543-97DD-31A914BB6A05) documentation.

At this step, you want to identify the most important features and how are these related to your customers attributes.

Watch the video below for a quick walk through of the lab.

[](youtube:Vk4vutHr1f8)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set and create training and test data.

    ```python
    <copy>
    ltv_dat = oml_cust.split()
    train_ltv = ltv_dat[0]
    test_ltv = ltv_dat[1]
    </copy>
    ```

3. Specify settings.

    ```python
    <copy>
    setting = {'SVDS_SCORING_MODE':'SVDS_SCORING_PCA', 'ODMS_DETAILS':'ODMS_ENABLE'}
    </copy>
    ```

    > **Note** : For the complete list of settings, check the [`DBMS_DATA_MINING` — Global Settings](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-24047A09-0542-4870-91D8-329F28B0ED75) table.

4. Create an SVD model object.

    ```python
    <copy>
    svd_mod = oml.svd(**setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Singular Value Decomposition](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/singular-value-decomposition.html#GUID-FA08B2D3-3DF4-4311-A30F-0DB085C7AFED) page in OML user guide.

5. Fit the model according to the training data and parameter settings showing the model details.

    ```python
    <copy>
    svd_mod = svd_mod.fit(train_ltv, case_id = 'CUST_ID')
    svd_mod
    </copy>
    ```

6. Use the model to make predictions on the test data.

    ```python
    <copy>
    predictions = svd_mod.predict(test_ltv,
                     supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                      'FIRST','LTV_BIN']])
    predictions
    </copy>
    ```

7. List the most important features for customers classified as *VERY HIGH*.

    ```python
    <copy>
    predictions[predictions['LTV_BIN']
            == 'VERY HIGH'].crosstab('LTV_BIN',
                                     'FEATURE_ID').sort_values('count',
                                                                   ascending=False)
    </copy>
    ```

8. What about the most important features for customers classified as *HIGH?*

    ```python
    <copy>
    predictions[predictions['LTV_BIN']
            == 'HIGH'].crosstab('LTV_BIN',
                                     'FEATURE_ID').sort_values('count',
                                                                   ascending=False)
    </copy>
    ```

9. Verify the most important features for customers classified as *MEDIUM*.

    ```python
    <copy>
    predictions[predictions['LTV_BIN']
            == 'MEDIUM'].crosstab('LTV_BIN',
                                     'FEATURE_ID').sort_values('count',
                                                                   ascending=False)
    </copy>
    ```

10. Finally, list the most important features for customers classified as *LOW*. Draw a conclusion.

    ```python
    <copy>
    predictions[predictions['LTV_BIN']
            == 'LOW'].crosstab('LTV_BIN',
                                     'FEATURE_ID').sort_values('count',
                                                                   ascending=False)
    </copy>
    ```

11. Perform dimensionality reduction and return values for the two features that have the highest `topN` values.

    ```python
    <copy>
    svd_mod.transform(test_ltv,
                      supplemental_cols = test_ltv[:, ['CUST_ID', 'LTV_BIN']],
                             topN = 2).sort_values(by = ['CUST_ID', 'TOP_1', 'TOP_1_VAL'])
    </copy>
    ```

12. List the most important customer attributes for the most important feature.

    ```python
    <copy>
    svd_mod.features[svd_mod.features['FEATURE_ID']
                     == 1].sort_values('VALUE', ascending=False).head()
    </copy>
    ```


## Task 8: Automated Machine Learning: Algorithm Selection

Automated Machine Learning (AutoML) provides a built-in expert system for data analytics and modeling that you can employ to build machine learning models.

Any modeling problem for a specified data set and prediction task involves a sequence of data cleansing and preprocessing, algorithm selection, and model tuning tasks. Each of these steps require data science expertise to help guide the process to an efficient final model. Automated Machine Learning (AutoML) automates this process with its built-in data science expertise.

> **Note** : For more information, visit [About Association](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/association.html#GUID-2FE196F3-94C5-4EDB-9AEC-40DCB43E8A89) documentation.

At this step, you will use AutoML to select the best Oracle Machine Learning algorithm based on the characteristics of the data set and the task. No single algorithm works best for all modeling problems. AutoML ranks the candidate algorithms according to how likely each is to produce a quality model. Compare this to the first part of the workshop where you experimented with Decision Tree and Neural Networks algorithms manually.

Watch the video below for a quick walk through of the lab.

[](youtube:5YritI-0_KY)

1. Import `automl` from `oml` Python library.

    ```python
    <copy>
    from oml import automl
    </copy>
    ```

2. Create an OML data frame proxy object that represents the database table. Create two data sets, one for classification task called `oml_cust_c`, and another for regression task called `oml_cust_r`.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust_c = oml_cust.drop('LTV')
    oml_cust_r = oml_cust.drop('LTV_BIN')
    </copy>
    ```

3. Split the data set into training and test data for classification task.

    ```python
    <copy>
    train, test = oml_cust_c.split(ratio=(0.8, 0.2), seed = 1234)
    X, y = train.drop('LTV_BIN'), train['LTV_BIN']
    X_test, y_test = test.drop('LTV_BIN'), test['LTV_BIN']
    </copy>
    ```

4. Create an automated algorithm selection object with `f1_macro` as the `score_metric` argument.

    ```python
    <copy>
    asel_c = automl.AlgorithmSelection(mining_function='classification',
                                       score_metric='f1_macro', parallel=4)
    </copy>
    ```

    > **Note** : For more information, visit [Classification and Regression Metrics](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/about-automl.html#GUID-9F514C2B-1772-4073-807F-3E829D5D558C) documentation.

5. Run algorithm selection to get the top k predicted algorithms and their ranking without tuning.

    ```python
    <copy>
    algo_ranking_c = asel_c.select(X, y, k=3)
    </copy>
    ```

6. Show the selected and tuned model.

    ```python
    <copy>
    [(m, "{:.2f}".format(s)) for m,s in algo_ranking_c]
    </copy>
    ```

7. Split the data set into training and test data for regression task.

    ```python
    <copy>
    train, test = oml_cust_r.split(ratio=(0.8, 0.2), seed = 1234)
    X, y = train.drop('LTV'), train['LTV']
    X_test, y_test = test.drop('LTV'), test['LTV']
    </copy>
    ```

8. Create an automated algorithm selection object with `f1_macro` as the `score_metric` argument.

    ```python
    <copy>
    asel_r = automl.AlgorithmSelection(mining_function='regression',
                                       score_metric='r2', parallel=4)
    </copy>
    ```

9. Run algorithm selection to get the top k predicted algorithms and their ranking without tuning.

    ```python
    <copy>
    algo_ranking_r = asel_r.select(X, y, k=3)
    </copy>
    ```

10. Show the selected and tuned model.

    ```python
    <copy>
    [(m, "{:.2f}".format(s)) for m,s in algo_ranking_r]
    </copy>
    ```

As you can see, AutoML is able to provide you the algorithms and a ranking of the algorithms best for the data set automatically for the Classification and Regression machine learning types.

## Task 9: Automated Machine Learning: Feature Selection

AutoML Feature Selection identifies the most relevant feature subsets for a training data set and an Oracle Machine Learning algorithm. In a data analytics application, feature selection is a critical data preprocessing step that has a high impact on both runtime and model performance.

> **Note** : For more information on this algorithm, visit [Feature Selection](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/feature-selection.html#GUID-576E9C37-6743-4DCC-8939-44772A5C41AB) documentation.

In this AutoML example, you will reduce the number of features of your customers data set, and compare the accuracy score of a Support Vector Machine (SVM) algorithm for a classification task.

Watch the video below for a quick walk through of the lab.

[](youtube:oU7_kRoXVG8)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV").drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data for classification task.

    ```python
    <copy>
    train, test = oml_cust.split(ratio=(0.8, 0.2), seed = 1234,
                                 strata_cols = 'LTV_BIN')
    X_train, y_train = train.drop('LTV_BIN'), train['LTV_BIN']
    X_test, y_test = test.drop('LTV_BIN'), test['LTV_BIN']
    </copy>
    ```

3. Default SVM model performance before feature selection.

    ```python
    <copy>
    mod = oml.svm(mining_function='classification').fit(X_train, y_train)
    "{:.2}".format(mod.score(X_test, y_test))
    </copy>
    ```

4. Create an automated feature selection object with accuracy as the `score_metric`.

    ```python
    <copy>
    fs = automl.FeatureSelection(mining_function='classification',
                                 score_metric='accuracy', parallel=4)
    </copy>
    ```

5. Get the reduced feature subset on the train data set. How many features have been reduced from the original data set?

    ```python
    <copy>
    subset = fs.reduce('svm_linear', X_train, y_train)
    "{} features reduced to {}".format(len(X_train.columns),
                                       len(subset))
    </copy>
    ```

6. Use the subset to select the features and create a SVM model on the new reduced data set. Did your model accuracy improve with less features?

    ```python
    <copy>
    X_new = X_train[:,subset]
    X_test_new = X_test[:,subset]
    mod = oml.svm(mining_function='classification').fit(X_new, y_train)
    "{:.2} with {:.1f}x feature reduction".format(mod.score(X_test_new, y_test),
                                                  len(X_train.columns)/len(X_new.columns))
    </copy>
    ```

7. For reproducible results, add `CUST_ID` column unique case identifier.

    ```python
    <copy>
    train, test = oml_cust.split(ratio=(0.8, 0.2), seed = 1234,
                                 hash_cols='CUST_ID', strata_cols = 'LTV_BIN')
    X_train, y_train = train.drop('LTV_BIN'), train['LTV_BIN']
    X_test, y_test = test.drop('LTV_BIN'), test['LTV_BIN']
    </copy>
    ```

8. Provide the `CUST_ID` column name to the feature selection reduce function. Does it reduce more the number of features when case ID is provided?

    ```python
    <copy>
    subset = fs.reduce('svm_linear', X_train,
                       y_train, case_id='CUST_ID')
    "{} features reduced to {} with case_id".format(len(X_train.columns)-1, len(subset))
    </copy>
    ```


## Task 10: Automated Machine Learning: Model Selection

AutoML Model Selection automatically selects an Oracle Machine Learning algorithm according to the selected score metric and then tunes that algorithm. It supports classification and regression algorithms.

> **Note** : For more information, visit [Model Selection](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/model-selection.html#GUID-E2C3D9D2-D685-4AF7-8A04-32127A5CCF07) documentation.

In this example, you will create an AutoML `ModelSelection` object and then use this object to select and tune the best model for your task.

Watch the video below for a quick walk through of the lab.

[](youtube:u697lA4XjPM)

1. Create an OML data frame proxy object that represents your database table.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV").drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data for classification.

    ```python
    <copy>
    train, test = oml_cust.split(ratio=(0.8, 0.2), seed = 1234)
    X, y = train.drop('LTV_BIN'), train['LTV_BIN']
    X_test, y_test = test.drop('LTV_BIN'), test['LTV_BIN']
    </copy>
    ```

3. Create an automated model selection object with `f1_macro` as the `score_metric` argument.

    ```python
    <copy>
    ms = automl.ModelSelection(mining_function='classification',
                               score_metric='f1_macro', parallel=4)
    </copy>
    ```

4. Run model selection to get the top (k=1) predicted algorithm, that defaults to the tuned model.

    ```python
    <copy>
    select_model = ms.select(X, y, k=1)
    </copy>
    ```

5. Show the selected and tuned model.

    ```python
    <copy>
    select_model
    </copy>
    ```


## Task 11: Automated Machine Learning: Model Tuning

AutoML Model Tuning tunes the hyperparameters for the specified classification or regression algorithm and training data. This feature automates the tuning process using a highly-parallel, asynchronous gradient-based hyperparameter optimization algorithm.

> **Note** : For more information on this algorithm, visit [Model Tuning](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/model-tuning.html#GUID-0F5153CC-39E5-4189-9615-09D8F39D7FBF) documentation.

In this case, you will execute an automated model tuning process for a classification task using Decision Tree (DT) algorithm.

Watch the video below for a quick walk through of the lab.

[](youtube:lBAKjZvLZmE)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV").drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data for classification.

    ```python
    <copy>
    train, test = oml_cust.split(ratio=(0.8, 0.2), seed = 1234)
    X, y = train.drop('LTV_BIN'), train['LTV_BIN']
    X_test, y_test = test.drop('LTV_BIN'), test['LTV_BIN']
    </copy>
    ```

3. Start an automated model tuning run with a DT model.

    ```python
    <copy>
    at = automl.ModelTuning(mining_function='classification', parallel=4,
                            score_metric='accuracy')
    results = at.tune('dt', X, y)
    </copy>
    ```

    > **Note** : For more information, visit [Classification and Regression Metrics](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/about-automl.html#GUID-9F514C2B-1772-4073-807F-3E829D5D558C) documentation.

4. Show the DT tuned model details.

    ```python
    <copy>
    tuned_model = results['best_model']
    tuned_model
    </copy>
    ```

5. Show the best tuned model train score and the corresponding hyperparameters.

    ```python
    <copy>
    score, params = results['all_evals'][0]
    "{:.2}".format(score), ["{}:{}".format(k, params[k])
                            for k in sorted(params)]
    </copy>
    ```

6. Use the DT tuned model to get the score on the test set. How is the score on the test data compared to the score on training data?

    ```python
    <copy>
    "{:.2}".format(tuned_model.score(X_test, y_test))
    </copy>
    ```

    You may now **proceed to the next lab**.


## Acknowledgements
* **Authors** - Valentin Leonard Tabacaru
* **Last Updated By/Date** -  Valentin Leonard Tabacaru, February 2023
