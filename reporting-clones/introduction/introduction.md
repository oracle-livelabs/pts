# Read-only clones for reporting

## Introduction

Refreshable bidirectional read-only clones at pluggable database level and cross container operations can be used for data replication and reporting purposes. This workshop use case has two sites, Site A and Site B, but these principles can be applied to a multi-site configuration. Data in local pluggable databases can be updated, and data from read-only refreshable clones can be used for reporting. These clones can be used in read/write mode for testing purposes, too, and re-created when finished because it's not possible to turn them back into refreshable read-only clone mode.

Estimated Time: 2 hours

### Objectives

In this workshop you will:
* Create a Virtual Cloud Network (VCN)
* Provision two Database Systems (DB Systems)
* Connect to DB System Node via SSH
* Create users and application data
* Create a refreshable clone for the application PDB
* Change refresh mode configuration for the clone
* Perform cross-container operations on application PDBs
* Implement bidirectional application data cloning between sites

You will deploy this workflow

![Workflow](./images/.png "")

### Prerequisites

This workshop assumes you have:
* Access to Oracle Cloud Infrastructure
* Basic understanding of the Oracle Base Database Service
* Basic Oracle Database administration experience

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, February 2023
