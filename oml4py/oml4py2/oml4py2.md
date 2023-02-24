# Run OML4Py notebook part 2

## Introduction

Before running this lab, make sure you have completed **Run OML4Py notebook part 1**.

Estimated Time: 1 hour 50 min

### Objectives

In this lab, you will:
* Use Automated Machine Learning Model Tuning to improve accuracy for a Random Forest model;
* Identify patterns of association using Association Rules;
* Implement Expectation Maximization and K-Means algorithms for customer clustering;
* Practice Naive Bayes, Random Forest and Support Vector Machine algorithms for classification;
* Sentiment Analysis on free text customer reviews and comments using binary classification.

### Prerequisites

* Oracle Database 21c installed on-premise.
* Python, Jupyter Notebook, and required libraries.
* Must have completed the part-1 of this lab


## Task 11: Automated Machine Learning: Model Tuning (continued)

7. Optioanlly, an example invocation of model tuning with user-defined search ranges for selected hyperparameters on a new tuning metric (`f1_macro`).

    ```python
    <copy>
    search_space = {
       'RFOR_SAMPLING_RATIO': {'type': 'continuous', 'range': [0.01, 0.5]},
       'RFOR_NUM_TREES': {'type': 'discrete', 'range': [50, 100]},
       'TREE_IMPURITY_METRIC': {'type': 'categorical',
                                'range': ['TREE_IMPURITY_ENTROPY',
                                'TREE_IMPURITY_GINI']},}
    </copy>
    ```

8. Start an automated model tuning run with a Random Forest (RF) model, for comparison.

    ```python
    <copy>
    results = at.tune('rf', X, y, param_space=search_space)
    score, params = results['all_evals'][0]
    ("{:.2}".format(score), ["{}:{}".format(k, params[k]) for k in sorted(params)])
    </copy>
    ```

9. Show the RF tuned model details.

    ```python
    <copy>
    tuned_model = results['best_model']
    tuned_model
    </copy>
    ```

10. Use the RF tuned model to get the score on the test set. How is the score of RF model compared to DT model?

    ```python
    <copy>
    "{:.2}".format(tuned_model.score(X_test, y_test))
    </copy>
    ```

11. Some hyperparameter search ranges need to be defined based on the training data set sizes (for example, the number of samples and features). You can use placeholders specific to the data set, such as `$nr_features` and `$nr_samples`, as the search ranges.

    ```python
    <copy>
    search_space = {'RFOR_MTRY': {'type': 'discrete',
                                  'range': [1, '$nr_features/2']}}
    results = at.tune('rf', X, y, param_space=search_space)
    score, params = results['all_evals'][0]
    ("{:.2}".format(score), ["{}:{}".format(k, params[k])
                             for k in sorted(params)])
    </copy>
    ```


## Task 12: Identify patterns of association with Association Rules

Association is an Oracle Machine Learning function that discovers the probability of the co-occurrence of items in a collection. The relationships between co-occurring items are expressed as Association Rules (AR).

> **Note** : For more information, visit [About Association](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/association.html#GUID-2FE196F3-94C5-4EDB-9AEC-40DCB43E8A89) documentation.

At this step, you want to identify the relationship between your customers marital status and their LVT class.

Watch the video below for a quick walk through of the lab.

[](youtube:Lg7ab4Ujm3c)

1. Create training data. For this exercise, use a query to retrieve necessary values from `CUST_INSUR_LTV` table.

    > **Note** :  Notice at this step you create an OML data frame from a database query, instead of a database table, using the same `oml.sync` transparency layer function.

    ```python
    <copy>
    train_dat = oml.sync(query = 'select CUST_ID, MARITAL_STATUS, LTV_BIN from CUST_INSUR_LTV')
    train_dat
    </copy>
    ```

2. Count insurance customers in your training data frame by `MARITAL_STATUS` and `LTV_BIN` attributes.

    ```python
    <copy>
    train_dat.crosstab('MARITAL_STATUS',
                       'LTV_BIN').sort_values(['MARITAL_STATUS',
                                               'LTV_BIN'])
    </copy>
    ```

3. Convert data set to a pivot table using `MARITAL_STATUS` and `LTV_BIN` as columns containing the keys to group by.

    ```python
    <copy>
    train_dat.pivot_table('MARITAL_STATUS', 'LTV_BIN',
                          aggfunc = oml.DataFrame.count)
    </copy>
    ```

4. Specify settings.

    ```python
    <copy>
    setting = {'asso_min_support':'0.15', 'asso_min_confidence':'0.15'}
    </copy>
    ```

    > **Note** : For the complete list of settings, check the [Machine Learning Function Settings](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-CE514371-EC80-41EA-AB07-7F6501687D12) table for Association.

5. Create an AR model object.

    ```python
    <copy>
    ar_mod = oml.ar(**setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Association Rules](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/association-rules.html#GUID-4D047EAC-D134-49D7-A532-AB3B8A95DFA3) page in OML user guide.

6. Fit the model according to the training data and parameter settings. `case_id` parameter represents the name of a column that contains unique case identifiers.

    ```python
    <copy>
    ar_mod = ar_mod.fit(train_dat, case_id = 'CUST_ID')
    </copy>
    ```

7. Show details of the model.

    ```python
    <copy>
    ar_mod
    </copy>
    ```

8. Specify new settings for your Association machine learning function.

    ```python
    <copy>
    setting = {'asso_min_support':'0.1', 'asso_min_confidence':'0.1'}
    </copy>
    ```

9. Re-create an AR model object with new settings.

    ```python
    <copy>
    ar_mod = oml.ar(**setting)
    </copy>
    ```

10. Fit the model according to the training data and parameter settings, and show model details. `case_id` parameter represents the name of a column that contains unique case identifiers.

    ```python
    <copy>
    ar_mod = ar_mod.fit(train_dat, case_id = 'CUST_ID')    
    ar_mod
    </copy>
    ```

11. Do you see any relationship between your customers marital status and their `LVT` class?


## Task 13: Cluster customers using Expectation Maximization

Clustering analysis finds clusters of data objects that are similar to one another. The members of a cluster are more like each other than they are like members of other clusters. Clustering, like classification, is used to group or segment the data. Unlike classification, clustering models segment data into groups that were not previously defined, called unsupervised.

Expectation Maximization (EM) is a probabilistic, density-estimation clustering algorithm.

> **Note** : For more information on this algorithm, visit [Expectation Maximization](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/expectation-maximization.html#GUID-F4D117F3-FA0C-4CA4-9034-67D12339AE90) documentation.

Similar to K-Means (KM) clustering analysis, this is a market segmentation example, you group customers in four clusters, and you will let the algorithm define these four segments.

Watch the video below for a quick walk through of the lab.

[](youtube:CDdLMmSsDe4)

1. Generate an OML data frame from your database table. Use the entire data set, attributes and labels.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data. Use 75% train and 25% test ratio.

    ```python
    <copy>
    ltv_dat = oml_cust.split(ratio=(.75, .25))
    [split.shape for split in ltv_dat]
    </copy>
    ```

3. Create training data and test data.

    ```python
    <copy>
    train_ltv = ltv_dat[0]
    test_ltv = ltv_dat[1]
    </copy>
    ```

4. Specify algorithm settings.

    ```python
    <copy>
    setting = {'emcs_num_iterations': 100}
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Expectation Maximization](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-1796B451-BE1B-43BC-9839-05F5F73031C8) documentation.

5. Create an EM model object.

    ```python
    <copy>
    em_mod = oml.em(n_clusters = 4, **setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Expectation Maximization](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/expectation-maximization.html#GUID-09B57195-6672-4DDC-943B-24F74A9B41AB) page in OML user guide.

6. Fit the EM model according to the training data and parameter settings.

    ```python
    <copy>
    em_mod = em_mod.fit(train_ltv)
    </copy>
    ```

7. Show details of the model.

    ```python
    <copy>
    em_mod
    </copy>
    ```

8. Did your EM model converge? Convergence means the optimal solution has been reached and the iterations of the optimization has come to an end. EM has limited capacity for modeling high dimensional (wide) data. The presence of many attributes slows down model convergence, and the algorithm becomes less able to distinguish between meaningful attributes and noise. The algorithm is thus compromised in its ability to find correlations.

    ```python
    <copy>
    em_mod.global_stats[em_mod.global_stats['attribute name'] == 'CONVERGED']
    </copy>
    ```

9. What are the attributes your EM model considered as most important?

    ```python
    <copy>
    em_mod.attribute_importance.sort_values('ATTRIBUTE_RANK')
    </copy>
    ```

10. Increase the maximum number of iterations in the EM algorithm.

    ```python
    <copy>
    setting = {'emcs_num_iterations': 200}
    </copy>
    ```

11. Recreate an EM model object using new settings.

    ```python
    <copy>
    em_mod = oml.em(n_clusters = 4, **setting)
    </copy>
    ```

12. Refit the EM model using only the attributes identified by AI model.

    ```python
    <copy>
    em_mod = em_mod.fit(train_ltv[['N_MORTGAGES','HOUSE_OWNERSHIP',
                               'MORTGAGE_AMOUNT','N_TRANS_WEB_BANK',
                               'N_OF_DEPENDENTS','AGE','MARITAL_STATUS',
                               'TIME_AS_CUSTOMER']])
    </copy>
    ```

13. Show details of the model. Did your EM model converge this time?

    ```python
    <copy>
    em_mod
    </copy>
    ```

14. Use the model to make predictions on the test data. Each customer in the test data frame is assigned to one cluster. Clusters are identified by the `CLUSTER_ID` column.

    ```python
    <copy>
    em_mod.predict(test_ltv, supplemental_cols = test_ltv[:, ['CUST_ID','LAST','FIRST','LTV_BIN']])
    </copy>
    ```

15. Retrieve the `CLUSTER_ID` for the four clusters.

    ```python
    <copy>
    em_mod.predict(test_ltv).drop_duplicates().sort_values('CLUSTER_ID')
    </copy>
    ```

16. Count cluster members grouped by predefined life-time value class.

    ```python
    <copy>
    em_mod.predict(test_ltv,
          supplemental_cols = test_ltv[:,
                     ['LTV_BIN']]).crosstab('LTV_BIN',
                                     'CLUSTER_ID').sort_values('CLUSTER_ID')
    </copy>
    ```

17. Can you state that the four clusters are based on the predefined life-time value classes? Create an OML data frame with these predictions so you can investigate.

    ```python
    <copy>
    predictions = em_mod.predict(test_ltv,
                                 supplemental_cols = test_ltv[:, ['LTV',
                                                                  'LTV_BIN']])
    predictions
    </copy>
    ```

18. Plot these clusters using cluster ID on x-axis, and `LTV` value on y-axis. This way you can see if there is any relationship between predefined classes and clusters (cluster IDs have been changed, ID 3 is 1, ID 5 is 2, ID 6 is 3, and ID 7 is 4).

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


## Task 14: Classify customer records using Naive Bayes algorithm

Naive Bayes (NB) algorithm is based on conditional probabilities. It uses Bayes' theorem, a formula that calculates a probability by counting the frequency of values and combinations of values in the historical data.

> **Note** : For more information on this algorithm, visit [Naive Bayes](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/naive-bayes.html#GUID-BB77D68D-3E07-4522-ACB6-FD6723BDA92A) documentation.

In this example, you will classify your customers in four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*), based on combinations of feature values and their probability of occurrence.

Watch the video below for a quick walk through of the lab.

[](youtube:IPe74lNdPGI)

1. Create an OML data frame proxy object in Python that represents your Oracle Database data set.

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

4. Provide user specified settings for the mining function.

    ```python
    <copy>
    setting = {'CLAS_WEIGHTS_BALANCED': 'ON'}
    </copy>
    ```

    > **Note** : For the complete list of settings, check the [Machine Learning Function Settings](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-CE514371-EC80-41EA-AB07-7F6501687D12) table for Classification.

5. Create a NB model object.

    ```python
    <copy>
    nb_mod = oml.nb(**setting)
    </copy>
    ```

    > **Note** : To understand this model, visit the [Naive Bayes](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/naive-bayes.html#GUID-93F305B0-1691-429E-B804-F8A56F29F8C6) page in OML user guide.

6. Fit the NB model according to the training data and parameter settings.

    ```python
    <copy>
    nb_mod = nb_mod.fit(train_x, train_y, case_id = 'CUST_ID')
    </copy>
    ```

7. Show details of the model. A prior probability distribution, often simply called the prior, represent the relative proportions of customers by each pre-defined class. What are your NB model default priors?

    ```python
    <copy>
    nb_mod
    </copy>
    ```

8. List the 10 most important conditionals for customer to be in `LTV_BIN` class *VERY HIGH* and their probability of occurrence.

    ```python
    <copy>
    nb_mod.conditionals[
        nb_mod.conditionals['TARGET_VALUE']
        == 'VERY HIGH'].sort_values('CONDITIONAL_PROBABILITY',
                                    ascending=False)[['ATTRIBUTE_NAME', 'ATTRIBUTE_VALUE',
                                                      'CONDITIONAL_PROBABILITY', 'COUNT']].head(10)
    </copy>
    ```

9. Can you list the 5 most important conditionals for customer to be in `LTV_BIN` class *LOW* and their probability of occurrence?

10. Use the model to make predictions on test data.

    ```python
    <copy>
    nb_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']]).head(25)
    </copy>
    ```

11. Make predictions on new data and return the mean accuracy to score your model. Is your model accurate?

    ```python
    <copy>
    nb_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

12. There are ways to improve model accuracy. To correct for unrealistic distributions in the training data, you can specify priors for the model build process.

    ```python
    <copy>
    oml_cust[['LTV_BIN']].crosstab('LTV_BIN')
    </copy>
    ```

13. Calculate priors based on entire data set.

    ```python
    <copy>
    oml_cust[['LTV_BIN']].crosstab('LTV_BIN').concat(oml_cust[[
                            'LTV_BIN']].crosstab('LTV_BIN').rename({'count':
                                           'prior'})['prior']/15342).round(2)
    </copy>
    ```

    > **Note** : Costs, prior probabilities, and class weights are methods for biasing classification models. For more information, read [Priors and Class Weights](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/classification.html#GUID-590DD2C5-1BA5-40A3-9E3E-92AA2AE1D0EC) documentation.

14. Create a priors table in the database.

    ```python
    <copy>
    try:
       oml.drop('NB_PRIOR_PROBABILITY_LTV')
    except:
       pass
    priors = {'LOW': 0.09, 'MEDIUM': 0.33, 'HIGH': 0.48, 'VERY HIGH': 0.1}
    priors = oml.create(pd.DataFrame(list(priors.items()),
                         columns = ['TARGET_VALUE', 'PRIOR_PROBABILITY']),
                         table = 'NB_PRIOR_PROBABILITY_LTV')
    </copy>
    ```

15. Change the setting parameter and refit the model with your user-defined prior table.

    ```python
    <copy>
    new_setting = {'CLAS_WEIGHTS_BALANCED': 'OFF'}
    nb_mod = nb_mod.set_params(**new_setting).fit(train_x, train_y,
                                         case_id='CUST_ID', priors = priors)
    </copy>
    ```

16. Show details of the new model.

    ```python
    <copy>
    nb_mod
    </copy>
    ```

17. Use the new model to make predictions on test data.

    ```python
    <copy>
    nb_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']]).head(25)
    </copy>
    ```

18. Make predictions on test data and return the new mean accuracy. How much did your model accuracy improve?

    ```python
    <copy>
    nb_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

19. Change the setting parameter and refit the model, using the same user-defined prior table.

    ```python
    <copy>
    new_setting = {'CLAS_WEIGHTS_BALANCED': 'OFF',
                   'NABS_PAIRWISE_THRESHOLD': 0.022,
                   'NABS_SINGLETON_THRESHOLD': 0.025}
    nb_mod = nb_mod.set_params(**new_setting).fit(train_x, train_y,
                                         case_id='CUST_ID', priors = priors)
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Naive Bayes](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-A04C5F4E-1303-44DC-A7DA-185C969330C8) documentation.

20. Make predictions on test data and return the mean accuracy. Did your model accuracy improve with the new settings but using the same priors table?

    ```python
    <copy>
    nb_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```


## Task 15: Classify and rank attributes with Random Forest

Random Forest is a classification algorithm that builds an ensemble (forest) of trees. The algorithm builds a number of Decision Tree models and predicts using the ensemble. An individual decision tree is built by choosing a random sample from the training data set as the input. At each node of the tree, only a random sample of predictors is chosen for computing the split point. This introduces variation in the data used by the different trees in the forest.

> **Note** : For more information on this algorithm, visit [Random Forest](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/random-forest.html#GUID-B6506C33-8555-4181-993F-CD7D48B4DA3C) documentation.

In this example, you will use a Random Forest model to classify your customers in four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*), and provide attribute importance ranking of predictors.

Watch the video below for a quick walk through of the lab.

[](youtube:Mt1qZDp2mlM)

1. Create an OML data frame proxy object that represents your database table.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    oml_cust.head()
    </copy>
    ```

2. Split the data set into training and test data. Use 75% train and 25% test ratio.

    ```python
    <copy>
    ltv_dat = oml_cust.split(ratio=(.75, .25))
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

4. Create a cost matrix table in the database.

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

5. Create an RF model object.

    ```python
    <copy>
    rf_mod = oml.rf(tree_term_max_depth = '2')
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Decision Tree](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-03435110-D723-42FD-B4EA-39C86A039566) documentation.

    > **Note** : To understand this model, visit the [Random Forest](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/random-forest.html#GUID-C157A3B8-B26C-481F-ADEE-CD89AF7749D3) page in OML user guide.

6. Fit the RF model according to the training data and parameter settings.

    ```python
    <copy>
    rf_mod = rf_mod.fit(train_x, train_y, cost_matrix = cost_matrix)
    </copy>
    ```

7. Show details of the model.

    ```python
    <copy>
    rf_mod
    </copy>
    ```

8. Use the model to make predictions on the test data.

    ```python
    <copy>
    rf_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']]).head(25)
    </copy>
    ```

9. Return the prediction probability.

    ```python
    <copy>
    rf_mod.predict(test_ltv.drop('LTV_BIN'),
                   supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']],
                   proba = True).head(25)
    </copy>
    ```

10. Return the top two highest probability classes.

    ```python
    <copy>
    rf_mod.predict_proba(test_ltv.drop('LTV_BIN'),
                         supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                          'FIRST','LTV_BIN']],
                         topN = 2).sort_values(by = ['CUST_ID', 'LTV_BIN'])
    </copy>
    ```

11. Return mean accuracy for classification. Is your RF model accurate?

    ```python
    <copy>
    rf_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```

12. Try to increase accuracy with new parameters. Reset `TREE_TERM_MAX_DEPTH` and refit the model.

    ```python
    <copy>
    rf_mod.set_params(tree_term_max_depth = '3').fit(train_x, train_y, cost_matrix = cost_matrix)
    </copy>
    ```

13. Return new mean accuracy for classification. Did it work?

    ```python
    <copy>
    rf_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```


## Task 16: Classify your customers using Support Vector Machine

Support Vector Machine (SVM) is a powerful algorithm based on statistical learning theory. Oracle Machine Learning implements SVM for classification, regression, and anomaly detection.

> **Note** : For more information on this algorithm, visit [Support Vector Machine](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/support-vector-machine.html#GUID-FD5DF1FB-AAAA-4D4E-84A2-8F645F87C344) documentation.

In this example, you will build a SVM model to classify your customers in four `LTV_BIN` classes (*LOW*, *MEDIUM*, *HIGH*, and *VERY HIGH*), and score it for mean accuracy.

Watch the video below for a quick walk through of the lab.

[](youtube:6ms79gE0qgY)

1. Create training and test data as data frame proxy objects that represent your database table.

    ```python
    <copy>
    oml_cust = oml.sync(table = "CUST_INSUR_LTV")
    oml_cust = oml_cust.drop('LTV')
    ltv_dat = oml_cust.split()
    train_x = ltv_dat[0].drop('LTV_BIN')
    train_y = ltv_dat[0]['LTV_BIN']
    test_ltv = ltv_dat[1]
    </copy>
    ```

2. Create an SVM model object.

    ```python
    <copy>
    svm_mod = oml.svm('classification',
                      svms_kernel_function = 'dbms_data_mining.svms_linear')
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Support Vector Machine](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-12408982-E738-4D0F-A2BC-84D895E07ABB) documentation.

    > **Note** : To understand this model, visit the [Support Vector Machine](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/support-vector-machine.html#GUID-3824F5AA-202F-4478-909A-9CB25B952210) page in OML user guide.

3. Fit the SVM model according to the training data and parameter settings. Did you model converge?

    ```python
    <copy>
    svm_mod.fit(train_x, train_y)
    </copy>
    ```

4. Re-create your SVM model using Gaussian kernel function.

    ```python
    <copy>
    svm_mod = oml.svm('classification',
                      svms_kernel_function = 'dbms_data_mining.svms_gaussian')
    </copy>
    ```

    > **Note** : Read the [Kernel-Based Learning](https://docs.oracle.com/en/database/oracle/machine-learning/oml4sql/21/dmcon/support-vector-machine.html#GUID-F2D8C52C-AE2B-47ED-9E1F-F326950CC459) documentation to find the differences between the two functions to transform the input data for SVM.

5. Re-fit the SVM model. Did you model converge?

    ```python
    <copy>
    svm_mod.fit(train_x, train_y)
    </copy>
    ```

6. Use the model to make predictions on test data.

    ```python
    <copy>
    svm_mod.predict(test_ltv.drop('LTV_BIN'),
                    supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']]).head(25)
    </copy>
    ```

7. Return the prediction probability.

    ```python
    <copy>
    svm_mod.predict(test_ltv.drop('LTV_BIN'),
                    supplemental_cols = test_ltv[:, ['CUST_ID','LAST',
                                                    'FIRST','LTV_BIN']],
                    proba = True).head(25)
    </copy>
    ```

8. Return mean accuracy for classification.

    ```python
    <copy>
    svm_mod.score(test_ltv.drop('LTV_BIN'), test_ltv[:, ['LTV_BIN']])
    </copy>
    ```


## Task 17: Sentiment Analysis on Free Text Customer Reviews

The dataset can be downloaded from the links below, and cite the following ACL 2011 paper in order to use it in your projects:
Maas, A., Daly, R., Pham, P., Huang, D., Ng, A. and Potts, C. (2011). Learning Word Vectors for Sentiment Analysis: Proceedings of the 49th Annual Meeting of the Association for Computational Linguistics: Human Language Technologies. [online] Portland, Oregon, USA: Association for Computational Linguistics, pp.142–150. Available at: [http://www.aclweb.org/anthology/P11-1015](http://www.aclweb.org/anthology/P11-1015).

**No need to download it**, it is already imported in the pluggable database `OML_USER` schema: `TRAINING_DATA` and `TEST_DATA` tables.

This is a relatively small dataset for binary sentiment classification, featuring 25,000 movie reviews for training and 25,000 for testing. You can read the README file within the archive for more details about the dataset.
* Large Movie Review Dataset link: [http://ai.stanford.edu/~amaas/data/sentiment/](http://ai.stanford.edu/~amaas/data/sentiment/);
* Download link: [http://ai.stanford.edu/~amaas/data/sentiment/aclImdb_v1.tar.gz](http://ai.stanford.edu/~amaas/data/sentiment/aclImdb_v1.tar.gz).

During this exercise, you will use Oracle Data Mining with Text capabilities to create a Generalized Linear Model (GLM) classification model that will be trained to perform sentiment analysis on free text. Classification is a predictive mining function. A classification model uses historical data to predict a categorical target. Both training and testing reviews are prelabeled, to calibrate and evaluate the performance of your sentiment analysis classification model.

Watch the video below for a quick walk through of the lab.

[](youtube:gSpiNszuR90)

1. Select one review comment from any of the two tables, to see the format. These reviews are gathered on a web portal, and may contain some HTML tags.

    ```python
    <copy>
    pd.set_option('display.max_colwidth', 0)
    comment = oml.sync(query = 'select ID, SENTIMENT, FILE_CONTENT \
                                from TEST_DATA where ID = 1')
    comment
    </copy>```


2. Table `TRAINING_DATA` is used for training.

    ```python
    <copy>
    train_dat = oml.sync(query = 'select ID, SENTIMENT, FILE_CONTENT from TRAINING_DATA')
    train_dat.shape
    </copy>
    ```

3. Table \`TEST\_DATA \` is used for testing.

    ```python
    <copy>
    test_dat = oml.sync(query = 'select ID, SENTIMENT, FILE_CONTENT from TEST_DATA')
    test_dat.shape
    </copy>
    ```

4. Training data needs to be separated between features and labels. \`train\_x\` are the features, in this case user reviews and comments.

    ```python
    <copy>
    train_x = train_dat.drop('SENTIMENT')
    train_x.shape
    </copy>
    ```

5. \`train\_y\` specifies the label for each review, in this case \`SENTIMENT\` value.

    ```python
    <copy>
    train_y = train_dat['SENTIMENT']
    train_y.shape
    </copy>
    ```

6. \`CREATE\_PREFERENCE\` creates a lexer preference in the Text data dictionary, named \`sentiment\_anlsys_policy\`. \`CREATE\_POLICY\` procedure creates a policy to be used by OML.

    ```python
    <copy>
    cr = oml.cursor()
    cr.execute("Begin ctx_ddl.CREATE_PREFERENCE('sentiment_anlsys_lexer', 'BASIC_LEXER'); End;")
    cr.execute("Begin ctx_ddl.CREATE_POLICY('sentiment_anlsys_policy', lexer => 'sentiment_anlsys_lexer'); End;")
    cr.close()
    </copy>
    ```

7. `ctx_settings` is a list that specifies Oracle Text attribute-specific settings.

    ```python
    <copy>
    ctx_settings = {'FILE_CONTENT': 'TEXT(POLICY_NAME:sentiment_anlsys_policy)(TOKEN_TYPE:NORMAL)'}
    </copy>
    ```

8. Specify Generalized Linear Model (GLM) classification model settings.

    ```python
    <copy>
    settings = {'odms_text_policy_name': 'sentiment_anlsys_policy',
                'GLMS_SOLVER': 'dbms_data_mining.GLMS_SOLVER_QR'}
    </copy>
    ```

    > **Note** : For more information, visit [Algorithm Settings: Generalized Linear Models](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_DATA_MINING.html#GUID-4E3665B9-B1C2-4F6B-AB69-A7F353C70F5C) documentation.

9. Create a GLM classification model object.

    ```python
    <copy>
    glm_mod = oml.glm("classification", **settings)
    </copy>
    ```

10. Fit the GLM model according to the training data and parameter settings. The name of a column that contains unique case identifiers is used for `case_id` parameter. Use Oracle Text attribute-specific settings `ctx_settings` for this semantic binary classification use case.

    ```python
    <copy>
    glm_mod = glm_mod.fit(train_x, train_y, case_id = 'ID', ctx_settings = ctx_settings)
    </copy>
    ```

11. Show the model details. Did your model converge?

    ```python
    <copy>
    glm_mod
    </copy>
    ```

12. Use the model to make predictions on the test data. How are the `PREDICTION` values compared to the exact `SENTIMENT` values?

    ```python
    <copy>
    glm_mod.predict(test_dat.drop('SENTIMENT'),
                    supplemental_cols = test_dat[:, ['ID', 'SENTIMENT']])
    </copy>
    ```

13. Calculate the accuracy score value based on the test data. Is this score satisfactory? How would you improve this mean accuracy?

    ```python
    <copy>
    glm_mod.score(test_dat.drop('SENTIMENT'),
                  test_dat[:, ['SENTIMENT']])
    </copy>
    ```

14. Return the prediction probability.

    ```python
    <copy>
    glm_proba = glm_mod.predict(test_dat.drop('SENTIMENT'),
                                supplemental_cols = test_dat[:, ['ID', 'SENTIMENT']],
                                proba = True)
    glm_proba
    </copy>
    ```

15. As data is ordered by pre-label values, return first 15 rows that have a different prediction from the pre-label value (wrong predictions). These results are called *false negative*.

    ```python
    <copy>
    glm_proba[glm_proba['SENTIMENT'] != glm_proba['PREDICTION']].head(15)
    </copy>
    ```

16. Return first 15 rows that have a different prediction from the pre-label value (wrong predictions). These results are called *false positive*.

    ```python
    <copy>
    glm_proba[glm_proba['SENTIMENT'] != glm_proba['PREDICTION']].tail(15)
    </copy>
    ```

17. Calculate the number of *false positive* values from the total of 12,500 pre-labeled negative values.

    ```python
    <copy>
    false_positive = glm_proba[(glm_proba['SENTIMENT'] == 'NEGATIVE') &
                               (glm_proba['PREDICTION'] == 'POSITIVE'), :].__len__()
    false_positive
    </copy>
    ```

18. Calculate the number of *false negative* values from the total of 12,500 pre-labeled positive values.

    ```python
    <copy>
    false_negative = glm_proba[(glm_proba['SENTIMENT'] == 'POSITIVE') &
                               (glm_proba['PREDICTION'] == 'NEGATIVE'), :].__len__()
    false_negative
    </copy>
    ```

19. Populate the *confusion matrix*, also known as an *error matrix*.

    ```python
    <copy>
    confusion_matrix = pd.DataFrame({' ':['Predicted Positive', 'Predicted Negative'],
                                     'Actual Positive':[12500 - false_negative, false_negative],
                                     'Actual Negative':[false_positive, 12500 - false_positive]})
    confusion_matrix
    </copy>
    ```


## Acknowledgements
* **Authors** - Milton Wan, Valentin Leonard Tabacaru
* **Last Updated By/Date** -  Valentin Leonard Tabacaru, February 2023
