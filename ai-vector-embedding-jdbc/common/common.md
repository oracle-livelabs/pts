# Lab 1: Common Java Code

## Introduction

In this preparatory lab, we will review the Java code used in the later labs to utilize Oracle Database 23ai with JDBC to perform Similarity Search. If you are running the workshop in your environment, you can use whichever IDE you prefer.

Estimated Time: 20 minutes

---------------


### **Objectives**

In this lab, you will perform the following tasks:
* Task 1: Review the root environment
* Task 2: Review the ojdbc-vector-examples-common directory
* Task 3: Review the ojdbc-vector-examples-cohere directory
* Task 4: Review the ojdbc-vector-examples-openai directory


### Prerequisites

This lab asssumes you have:
* The latest version of Maven installed
* Java 11 or newer installed


## Task 1: Review the root environment

The main root directory which we will use shall be named "/home/oracle/ai-vector-search-oracle-jdbc-examples-main". 

Within this root directory, we will have 3 sub directories named **ojdbc-vector-example-common** , **ojdbc-vector-example-cohere**, **ojdbc-vector-example-openai** . We shall also will have a file named `example-config.properties`. We shall also have a pom.xml file.


### The TEMPLATE config file example-config.properties

The example-config.properties file is a configuration file for the AI Vector Search using Oracle JDBC Code Examples. This is a template file which includes the mandatory database connection details such as the `JDBC_URL`, `JDBC_USER`, and 'JDBC_PASSWORD`. The file also contains the configurations for different machine learning technologies, the API key and Model name for OpenAI, and various settings for Oracle Cloud Infrastructure(OCI) including the endpoint URL, configuration file location, profile, compartment OCID, and model ID for the embedding model. This setup ensures that the example code can interract with the database and the respective Machine Learning Services appropriately. </br>

</br>
*AGAIN THIS IS ONLY A TEMPLATE FILE* 

```
<copy>
# This is a configuration file for AI Vector Search: Oracle JDBC Code Examples.

# JDBC URL for an Oracle Database. This must be configured, regardless of
# which ML technology is used.
JDBC_URL=jdbc:oracle:thin:@host:port/service-name
# Note that JDBC_URL can have an Oracle Net Descriptor:
#   JDBC_URL=jdbc:oracle:thin:@(DESCRIPTION=...
# Or, if TNS_ADMIN is set as an environment variable, JDBC_URL can reference a
# tnsnames.ora alias:
#   JDBC_URL=jdbc:oracle:thin:@tns_names_alias

# Database username. This must be configured, regardless of which ML technology
# is used.
JDBC_USER=database-username

# Database password. This must be configured, regardless of which ML technology
# is used.
JDBC_PASSWORD=database-password

# Configuration for ONNX Runtime.
MODEL_PATH=/path/to/model.onnx

# Configuration for OpenAI ()
OPENAI_API_KEY=key-from-openai-account
OPENAI_MODEL=text-embedding-3-small

# OCI Configuration
# Endpoint URL for OCI Generative AI Service. Adjust according to your service region.
OCI_ENDPOINT=https://inference.generativeai.us-chicago-1.oci.oraclecloud.com

# Location of the OCI configuration file which includes your API credentials.
OCI_CONFIG_LOCATION=~/.oci/config

# The profile to use from the OCI configuration file. Typically "DEFAULT" or a user-defined profile.
OCI_CONFIG_PROFILE=DEFAULT

# The compartment OCID within OCI where the AI service is authorized.
OCI_COMPARTMENT_ID=ocid1.compartment.oc1..aaaaaaaah2dzjemfdkom3ngrrq6b3wk7c3wezj5ysuulxiwp56klk57gtfga

# The model ID for the embedding model to be used. Make sure this ID corresponds to the correct model in OCI.
OCI_MODEL_ID=cohere.embed-english-v3.0

</copy>
```

We will create a useable version of our **`example-config.properties`** file 
run the following command

```
<copy>
cp -i example-config.properties config.properties
</copy>
```
This will be the file that our Java classes will call later in the lab.

### **pom.xml**

The final individual file within this directory shall be the pom.xml file. This will be the main pom which will build out our applications. Below is our pom.xml file
</br>

```
<copy>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc-vector-examples</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>

    <name>VECTOR code examples</name>
    <description>
        Code examples which use the VECTOR data type with Oracle JDBC.
    </description>
    <url>https://github.com/oracle-samples/oracle-db-examples/tree/main/java/jdbc</url>
    <licenses>
        <license>
            <name>The Universal Permissive License (UPL), Version 1.0</name>
            <url>https://oss.oracle.com/licenses/upl/</url>
        </license>
    </licenses>
    <developers>
        <developer>
            <organization>Oracle America, Inc.</organization>
            <organizationUrl>http://www.oracle.com</organizationUrl>
        </developer>
    </developers>

    <properties>
        <maven.compiler.target>11</maven.compiler.target>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.release>11</maven.compiler.release>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    </properties>

    <modules>
        <module>ojdbc-vector-examples-common</module>
        <module>ojdbc-vector-examples-cohere</module>
        <module>ojdbc-vector-examples-openai</module>
    </modules>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
            </plugin>
        </plugins>
    </build>
</project>

</copy>
```


## Task 2: Review the ojdbc-vector-examples-common directory
The first directory we shall have is the ojdbc-vector-example-common. The files within this directory shall be accessed by all other folders in order to run our code. The folder shall have a pom.xml and the src folder. 

```
ai-vector-search-oracle-jdbc-examples-main
└── ojdbc-vector-example-common
    └── src
        └── main
            └── java
                └── oracle
                    └── jdbc
                        └── vector
                            └── examples
```
### **pom.xml within common**
Let's begin by first looking at the contents within the pom file. This file is located within the ojdbc-vector-example-common/ folder. </br>
That would be:
</br> 
**`/ai-vector-search-oracle-jdbc-examples-main/ojdbc-vector-example-common/`** 

The pom.xml file shall contain the following:

```
<copy>
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc-vector-examples</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>ojdbc-vector-examples-common</artifactId>
    <version>1.0.0</version>

    <dependencies>
        <dependency>
            <groupId>com.oracle.database.jdbc</groupId>
            <artifactId>ojdbc11</artifactId>
            <version>[23.4,)</version>
        </dependency>
    </dependencies>

</project>
</copy>
```
</br>

**Now we shall be working from the examples folder located in :**

**`ai-vector-search-oracle-jdbc-examples-main/ojdbc-vector-examples-common/src/main/java/oracle/jdbc/vector/examples/`**

### **Config.java**
Within the examples folder we shall have 4 files, `Config.java`, `Model.java`, `Schema.java`, and `SimilaritySearch.java`. </br>

The first file is `Config.java`. This class manages the configurable values for code exmaples by reading them from the config.properties file, JVM system properties or environment variables, in that order of precedence. It includes methods to retreive these values.

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples;

import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;

/**
 * Configurable values used by code examples. In order of precedence, these
 * values can be configured as JVM system properties, or environment variables.
 */
public final class Config {

  /**
   * Path to the configuration file
   */
  private static final Path CONFIG_PATH =
    Paths.get("config.properties").toAbsolutePath();

  /**
   * Configuration read from config.properties in the current working directory.
   */
  private static final Properties CONFIG_FILE = new Properties();
  static {
    try (Reader reader = Files.newBufferedReader(CONFIG_PATH)) {
      CONFIG_FILE.load(reader);
    }
    catch (IOException ioException) {
      System.out.println("Failed to read configuration from path:\n"
        + CONFIG_PATH
        + "\nFalling back to JVM system properties and environment variables");
    }
  }

  private Config() { }

  /**
   * Returns the value configured for a given <code>name</code>, or throws a
   * {@link RuntimeException} if no value is configured.
   *
   * @param name Name of a configurable value. Case sensitive. Not null.
   * @return The configured value. Not null.
   * @throws RuntimeException If no value is configured.
   */
  public static String get(String name) {
    String value = getOrDefault(name, null);

    if (value == null) {
      throw new RuntimeException(
        "\"" + name + "\" must be configured in:\n"
          + CONFIG_PATH
          + "\nOr set as a JVM system property or environment variable.");
    }

    return value;
  }

  /**
   * Returns the value configured for a given <code>name</code>, or a
   * <code>defaultValue</code> if no value is configured.
   *
   * @param name Name of a configurable value. Case sensitive. Not null.
   * @param defaultValue Default value. May be null.
   * @return The configured value, or the default if none is configured. May be
   * null if the <code>defaultValue</code> argument is null.
   */
  public static String getOrDefault(String name, String defaultValue) {
    String value = CONFIG_FILE.getProperty(name);
    if (value != null)
      return value;

    value = System.getProperty(name);
    if (value != null)
      return value;

    value = System.getenv(name);
    if (value != null)
      return value;

    return defaultValue;
  }
}
</copy>
```

### **Model.java**
Next Java file shall be the `Model.java`. This defines a 'Model' interface for machine learning models that generate vector embeddings for sentence in natural language. The 'embed' method takes an array of sentences as input and returns a 2D array of floats, where each `float[]` represents the embedding of the corresponding sentence in the input array.

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/

package oracle.jdbc.vector.examples;

/**
 * A machine learning (ML) model which generates a vector embedding for
 * sentences in a natural language. Implementations of this interface use
 * a particular model and a particular library or remote service to generate
 * the embedding.
 */
public interface Model {

  /**
   * Returns embeddings for the given <code>sentences</code>. In the returned
   * array, the <code>float[]</code> at index <i>n</i> is the embedding for
   * the sentence at index <i>n</i> in the given array of
   * <code>sentences</code>.
   *
   * @param sentences Sentences to embed. Not null. Not containing null.
   * @return Embeddings for the sentences. Not null. Not containing null.
   */
  float[][] embed(String[] sentences);

}
</copy>
```
</br>

### **Schema.java**

The next code shall be the `Schema.java`. 

This code defines a class that manages a database schema, which creates, populates and drops the schema. The schema features a table named 'my_data" with columns for: </br>
</br>
**id : A unique numeric id. It is a PRIMARY KEY**</br>
**info: A plain text sentence which conveys some information, such as, "San Francisco is in California".**</br>
**v: A vector embedding of the info within the sentence.**</br>
</br>
The 'create' method initializes the schema and populates it with example data, the 'drop' method removes the schema, and the 'vectorizeTable' method updates the table with vector embeddings generated by a provided model and creates an index for efficient similarity searches. The class handles SQL operations using JDBC, ensuring proper setup and teardown of the schema for interactive similarity search examples.

Below is the `Schema.java` file.

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples;

import oracle.jdbc.OracleType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * <p>
 * A database schema (a collection of tables and other database objects) which
 * are used in code examples. Methods of this class will create and drop the
 * schema.
 * </p><p>
 * The example schema includes a table named "my_data". This table has the
 * following columns:
 * <dl><dt>
 * id
 * </dt><dd>
 * A unique numeric id. It is a PRIMARY KEY
 * </dd><dt>
 * info
 * </dt><dd>
 * A plain text sentence which conveys some information, such as
 * "San Francisco is in California".
 * </dd><dt>
 * v
 * </dt><dd>
 * A vector embedding of the <code>info</code> sentence.
 * </dd></dl>
 * </p>
 */
public final class Schema {

  Schema() { }

  /**
   * Creates the schema, if it does not already exist.
   *
   * @param connection Connection used to create the schema. Not null.
   * @throws SQLException If creation fails due to a database error.
   */
  public static void create(Connection connection) throws SQLException {

    try (Statement statement = connection.createStatement()) {
      statement.execute("CREATE TABLE my_data ("
        + " id   NUMBER PRIMARY KEY,"
        + " info VARCHAR2(128),"
        + " v    VECTOR)");
    }
    catch (SQLException sqlException) {
      if (sqlException.getErrorCode() == 955) {
        // Return if ORA-00955 is caught. This error means the schema is already
        // created.
        return;
      }
      else {
        throw sqlException;
      }
    }

    try (PreparedStatement preparedStatement = connection.prepareStatement(
      "INSERT INTO my_data (id, info) VALUES (:1, :2)")) {

      preparedStatement.setInt(1, 1);
      preparedStatement.setString(2, "San Francisco is in California.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 2);
      preparedStatement.setString(2, "San Jose is in California.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 3);
      preparedStatement.setString(2, "Los Angeles is in California.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 4);
      preparedStatement.setString(2, "Buffalo is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 5);
      preparedStatement.setString(2, "Brooklyn is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 6);
      preparedStatement.setString(2, "Queens is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 7);
      preparedStatement.setString(2, "Harlem is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 8);
      preparedStatement.setString(2, "The Bronx is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 9);
      preparedStatement.setString(2, "Manhattan is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 10);
      preparedStatement.setString(2, "Staten Island is in New York.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 11);
      preparedStatement.setString(2, "Miami is in Florida.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 12);
      preparedStatement.setString(2, "Tampa is in Florida.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 13);
      preparedStatement.setString(2, "Orlando is in Florida.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 14);
      preparedStatement.setString(2, "Dallas is in Texas.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 15);
      preparedStatement.setString(2, "Houston is in Texas.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 16);
      preparedStatement.setString(2, "Austin is in Texas.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 17);
      preparedStatement.setString(2, "Phoenix is in Arizona.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 18);
      preparedStatement.setString(2, "Las Vegas is in Nevada.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 19);
      preparedStatement.setString(2, "Portland is in Oregon.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 20);
      preparedStatement.setString(2, "New Orleans is in Louisiana.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 21);
      preparedStatement.setString(2, "Atlanta is in Georgia.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 22);
      preparedStatement.setString(2, "Chicago is in Illinois.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 23);
      preparedStatement.setString(2, "Cleveland is in Ohio.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 24);
      preparedStatement.setString(2, "Boston is in Massachusetts.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 25);
      preparedStatement.setString(2, "Baltimore is in Maryland.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 26);
      preparedStatement.setString(2, "Charlotte is in North Carolina.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 27);
      preparedStatement.setString(2, "Raleigh is in North Carolina.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 100);
      preparedStatement.setString(2, "Ferraris are often red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 101);
      preparedStatement.setString(2, "Teslas are electric.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 102);
      preparedStatement.setString(2, "Mini coopers are small.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 103);
      preparedStatement.setString(2, "Fiat 500 are small.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 104);
      preparedStatement.setString(2, "Dodge Vipers are wide.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 105);
      preparedStatement.setString(2, "Ford 150 are popular.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 106);
      preparedStatement.setString(2, "Alfa Romeos are fun.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 107);
      preparedStatement.setString(2, "Volvos are safe.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 108);
      preparedStatement.setString(2, "Toyotas are reliable.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 109);
      preparedStatement.setString(2, "Hondas are reliable.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 110);
      preparedStatement.setString(2, "Porsches are fast and reliable.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 111);
      preparedStatement.setString(2, "Nissan GTRs are great");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 112);
      preparedStatement.setString(2, "NISMO is awesome");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 113);
      preparedStatement.setString(2, "Tesla Cybertrucks are awesome");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 114);
      preparedStatement.setString(2, "Jeep Wranglers are fun.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 200);
      preparedStatement.setString(2, "Bananas are yellow.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 201);
      preparedStatement.setString(2, "Kiwis are green inside.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 202);
      preparedStatement.setString(2, "Kiwis are brown on the outside.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 203);
      preparedStatement.setString(2, "Kiwis are birds.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 204);
      preparedStatement.setString(2, "Kiwis taste good.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 205);
      preparedStatement.setString(2, "Ripe strawberries are red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 206);
      preparedStatement.setString(2, "Apples can be green, yellow or red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 207);
      preparedStatement.setString(2, "Ripe cherries are red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 208);
      preparedStatement.setString(2, "Pears can be green, yellow or brown.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 209);
      preparedStatement.setString(2, "Oranges are orange.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 210);
      preparedStatement.setString(2, "Peaches can be yellow, orange or red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 211);
      preparedStatement.setString(2, "Peaches can be fuzzy.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 212);
      preparedStatement.setString(2, "Grapes can be green, red or purple.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 213);
      preparedStatement.setString(2, "Watermelons are green on the outside.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 214);
      preparedStatement.setString(2, "Watermelons are red on the outside.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 215);
      preparedStatement.setString(2, "Blueberries are blue.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 216);
      preparedStatement.setString(2, "Limes are green.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 217);
      preparedStatement.setString(2, "Lemons are yellow.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 218);
      preparedStatement.setString(2, "Ripe tomatoes are red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 219);
      preparedStatement.setString(2, "Unripe tomatoes are green.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 220);
      preparedStatement.setString(2, "Ripe raspberries are red.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 221);
      preparedStatement.setString(2, "Mangoes can be yellow, gold, green or orange.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 300);
      preparedStatement.setString(2, "Tigers have stripes.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 301);
      preparedStatement.setString(2, "Lions are big.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 302);
      preparedStatement.setString(2, "Mice are small.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 303);
      preparedStatement.setString(2, "Cats do not care.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 304);
      preparedStatement.setString(2, "Dogs are loyal.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 305);
      preparedStatement.setString(2, "Bears are hairy.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 306);
      preparedStatement.setString(2, "Pandas are black and white.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 307);
      preparedStatement.setString(2, "Zebras are black and white.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 308);
      preparedStatement.setString(2, "Penguins can be black and white.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 309);
      preparedStatement.setString(2, "Puffins can be black and white.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 310);
      preparedStatement.setString(2, "Giraffes have long necks.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 311);
      preparedStatement.setString(2, "Elephants have trunks.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 312);
      preparedStatement.setString(2, "Horses have four legs.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 313);
      preparedStatement.setString(2, "Birds can fly.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 314);
      preparedStatement.setString(2, "Birds lay eggs.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 315);
      preparedStatement.setString(2, "Fish can swim.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 316);
      preparedStatement.setString(2, "Sharks have lots of teeth.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 317);
      preparedStatement.setString(2, "Flies can fly.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 318);
      preparedStatement.setString(2, "Snakes have fangs.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 319);
      preparedStatement.setString(2, "Hyenas laugh.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 320);
      preparedStatement.setString(2, "Crocodiles lurk.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 321);
      preparedStatement.setString(2, "Spiders have eight legs.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 322);
      preparedStatement.setString(2, "Wolves are hairy.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 323);
      preparedStatement.setString(2, "Mountain Lions eat deer.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 324);
      preparedStatement.setString(2, "Kangaroos can hop.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 325);
      preparedStatement.setString(2, "Turtles have shells.");
      preparedStatement.addBatch();


      preparedStatement.setInt(1, 400);
      preparedStatement.setString(2, "Ibaraki is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 401);
      preparedStatement.setString(2, "Tochigi is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 402);
      preparedStatement.setString(2, "Gunma is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 403);
      preparedStatement.setString(2, "Saitama is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 404);
      preparedStatement.setString(2, "Chiba is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 405);
      preparedStatement.setString(2, "Tokyo is in Kanto.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 406);
      preparedStatement.setString(2, "Kanagawa is in Kanto.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 500);
      preparedStatement.setString(2, "Eggs are egg shaped.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 501);
      preparedStatement.setString(2, "The answer to life is 42.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 502);
      preparedStatement.setString(2, "To be, or not to be, that is the question.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 503);
      preparedStatement.setString(2, "640K ought to be enough for anybody.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 504);
      preparedStatement.setString(2, "Man overboard.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 505);
      preparedStatement.setString(2, "The world is your oyster.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 506);
      preparedStatement.setString(2, "One small step for Mankind.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 507);
      preparedStatement.setString(2, "Bitcoin is cryptocurrency.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 508);
      preparedStatement.setString(2, "Saturn has rings.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 600);
      preparedStatement.setString(2, "Catamarans have two hulls.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 601);
      preparedStatement.setString(2, "Monohulls have a single hull.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 602);
      preparedStatement.setString(2, "Foiling sailboats are fast.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 603);
      preparedStatement.setString(2, "Cutters have two headsails.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 604);
      preparedStatement.setString(2, "Yawls ave two masts.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 605);
      preparedStatement.setString(2, "Sloops have one mast.");
      preparedStatement.addBatch();


      preparedStatement.setInt(1, 900);
      preparedStatement.setString(2, "Oracle CloudWorld Las Vegas was on September 18–21, 2023");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 901);
      preparedStatement.setString(2, "Oracle CloudWorld Las Vegas was at The Venetian Convention and Expo Center");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 902);
      preparedStatement.setString(2, "Oracle CloudWorld Dubai is on 23 January 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 903);
      preparedStatement.setString(2, "Oracle CloudWorld Dubai is at the Dubai World Trade Centre");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 904);
      preparedStatement.setString(2, "Oracle CloudWorld Mumbai is on 14 February 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 905);
      preparedStatement.setString(2, "Oracle CloudWorld Mumbai is at the Jio World Convention Centre");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 906);
      preparedStatement.setString(2, "Oracle CloudWorld London is on 14 March 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 907);
      preparedStatement.setString(2, "Oracle CloudWorld London is at the ExCeL London");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 908);
      preparedStatement.setString(2, "Oracle CloudWorld Milan is on 21 March 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 909);
      preparedStatement.setString(2, "Oracle CloudWorld Milan is at the Milano Convention Centre");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 910);
      preparedStatement.setString(2, "Oracle CloudWorld Sao Paulo is on 4 April 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 911);
      preparedStatement.setString(2, "Oracle CloudWorld Sao Paulo is at The World Trade Center São Paulo.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 912);
      preparedStatement.setString(2, "Oracle CloudWorld Singapore is on 16 April 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 913);
      preparedStatement.setString(2, "Oracle CloudWorld Singapore is at the TBD");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 914);
      preparedStatement.setString(2, "Oracle CloudWorld Tokyo is on 18 April 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 915);
      preparedStatement.setString(2, "Oracle CloudWorld Tokyo is at The Prince Park Tower Tokyo.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 916);
      preparedStatement.setString(2, "Oracle CloudWorld Mexico City is on 25 April 2024");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 917);
      preparedStatement.setString(2, "Oracle CloudWorld Mexico City is at the Centro Citibanex.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 1000);
      preparedStatement.setString(2, "Dubai is in the United Arab Emirates.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1001);
      preparedStatement.setString(2, "The Burj Khalifa is in Dubai.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1002);
      preparedStatement.setString(2, "The Burj Khalifa is the tallest building in the world.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1003);
      preparedStatement.setString(2, "Dubai is in the Persian Gulf.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1004);
      preparedStatement.setString(2, "The United Arab Emirates consists of seven Emirates.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1005);
      preparedStatement.setString(2, "The Emirates are Abu Dhabi, Ajman, Dubai, Fujairah, Ras Al Khaimah, Sharjah and Umm Al Quwain.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1006);
      preparedStatement.setString(2, "The Emirates Mars Mission sent the Hope probe into orbit around Mars.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1007);
      preparedStatement.setString(2, "Sheikh Mohamed bin Zayed Al Nahyan is the president of the United Arab Emirates.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1008);
      preparedStatement.setString(2, "Emirates is the largest airline in the Middle East.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1009);
      preparedStatement.setString(2, "Emirates operates to more than 150 cities in 80 countries.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1010);
      preparedStatement.setString(2, "Emirates operates a fleet of nearly 300 aircraft.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1011);
      preparedStatement.setString(2, "Emirates sponsors the Arsenal Football Club.");
      preparedStatement.addBatch();

      preparedStatement.setInt(1, 1100);
      preparedStatement.setString(2, "Mumbai is in India.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1101);
      preparedStatement.setString(2, "Mumbai is the capital city of the Indian state of Maharashtra.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1102);
      preparedStatement.setString(2, "Mumbai is the Indian state of Maharashtra.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1103);
      preparedStatement.setString(2, "Mumbai is on the west coast of India.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1104);
      preparedStatement.setString(2, "Mumbai is the de facto financial centre of India.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1105);
      preparedStatement.setString(2, "Mumbai has a population of about 12.5 million people.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1106);
      preparedStatement.setString(2, "Mumbai is hot with an average minimum temperature of 24 degrees celsius.");
      preparedStatement.addBatch();
      preparedStatement.setInt(1, 1107);
      preparedStatement.setString(2, "Common languages in Mumbai are Marathi, Hindi, Gujarati, Urdu, Bambaiya  and English.");
      preparedStatement.addBatch();

      preparedStatement.executeBatch();
    }
  }

  /**
   * Drops the schema, if it exists.
   * @param connection Connection used to drop the schema. Not null.
   * @throws SQLException If dropping fails due to a database error.
   */
  public static void drop(Connection connection) throws SQLException {
    try (Statement statement = connection.createStatement()) {
      statement.addBatch("DROP TABLE IF EXISTS my_data PURGE");
      statement.addBatch("DROP INDEX IF EXISTS my_data_v");
      statement.executeBatch();
    }
  }

  /**
   * Updates the table to store vector embeddings generated by a given
   * <code>model</code>.
   *
   * @param connection Connection to use for updating the table. Not null.
   * @param model Model to use for generating vector embeddings. Not null.
   * @throws SQLException If a database failure occurs when updating the table.
   */
  public static void vectorizeTable(Connection connection, Model model)
    throws SQLException {

    class IdInfo {
      int id;
      String info;
    }

    ArrayList<IdInfo> idInfos = new ArrayList<>();
    try (
      Statement statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery(
        "SELECT id, info FROM my_data")) {
      while (resultSet.next()) {
        IdInfo idInfo = new IdInfo();
        idInfo.id = resultSet.getInt("id");
        idInfo.info = resultSet.getString("info");
        idInfos.add(idInfo);
      }
    }

    String[] sentences = idInfos.stream()
      .map(idInfo -> idInfo.info)
      .toArray(String[]::new);

    float[][] embeddings = model.embed(sentences);

    try (PreparedStatement update = connection.prepareStatement(
      "UPDATE my_data SET v=? WHERE id=?")) {
      for (int i = 0; i < idInfos.size(); i++) {
        update.setObject(1, embeddings[i], OracleType.VECTOR);
        update.setInt(2, idInfos.get(i).id);
        update.addBatch();
      }
      update.executeBatch();
    }

    try (Statement statement = connection.createStatement()) {
      statement.execute("CREATE VECTOR INDEX my_data_v_index"
        + " ON my_data (v)"
        + " ORGANIZATION INMEMORY NEIGHBOR GRAPH"
        + " DISTANCE COSINE"
        + " WITH TARGET ACCURACY 95"
        + " PARALLEL 4");
    }
  }

}

</copy>
```

### **SimilaritySearch.java**

The final Java file **SimilaritySearch.java** . This code defines the SimilaritySearch class that performs an interactive similarity search using vector embeddings of text sentences with our Oracle Database. The search process uses the 'Model' to generate the vector embeddings, which can be implemented using remote services like Generative Ai service on OCI or OpenAI, or local runtimes like ONNX. The program connects to the Oracle Database, allows the user to create or use an existing schema, and performs searches based on user input, displaying the top matches using the 'vector_distance' function of the Oracle Database. Additionally, it measures and prints the time taken for each similarity search. </br>

</br>

Below is the `SimilaritySearch.java` code

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples;

import oracle.jdbc.OracleType;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * <p>
 * An interactive command line program that performs a similarity search using
 * a vector embedding of text sentences. The search is implemented using Oracle
 * Database via the Oracle JDBC Driver. Vector embeddings are generated by an
 * abstract {@link Model}. The <code>Model</code> may be implemented using a
 * remote service such as Cohere or OpenAI. It can also be implemented using a
 * local runtime, such as ONNX.
 * </p>
 */
public class SimilaritySearch {

  private SimilaritySearch() { }

  /**
   * <p>
   * Runs the interactive search with embeddings generated by a given
   * <code>Model</code>.
   * </p><p>
   * This method connects to an Oracle Database and then prompts the user to
   * generate a schema, or use an existing one. The user can then enter search
   * terms and the terminal will display the top matches based on a
   * <code>vector_distance</code> function which is built-in to Oracle Database.
   * </p>
   * @param model Model used to generated vector embeddings. Not null.
   */
  public static void run(Model model) {
    try (
      Connection connection = DriverManager.getConnection(
        Config.get("JDBC_URL"),
        Config.get("JDBC_USER"),
        Config.get("JDBC_PASSWORD"));
      PreparedStatement query = connection.prepareStatement(
        "SELECT info"
          + " FROM my_data"
          + " ORDER BY VECTOR_DISTANCE(v, ?, COSINE)"
          + " FETCH APPROX FIRST ? ROWS ONLY");
    ) {

      // Do we need to create the table and vectorize the data?
      System.out.print("Create schema? (Y/N) ");
      String input =
        new BufferedReader(new InputStreamReader(System.in, UTF_8)).readLine();
      if (input.compareToIgnoreCase("y") == 0) {
        Schema.drop(connection);
        Schema.create(connection);
        Schema.vectorizeTable(connection, model);
      }

      while(true) {
        System.out.print("Search for ('bye' to exit): ");
        input =
          new BufferedReader(new InputStreamReader(System.in, UTF_8))
            .readLine();
        if (input.compareToIgnoreCase("bye") == 0) {
          break;
        }

        long startTime = System.nanoTime(); // Starts the timing before the embedding
        float[] embedding = model.embed(new String[]{input})[0];

        query.setObject(1, embedding, OracleType.VECTOR);
        query.setInt(2, 5/*TODO: Let users configure this*/);
        try (ResultSet resultSet = query.executeQuery()) {
          while (resultSet.next()) {
            System.out.println(resultSet.getString("info"));
          }
        }

        long endTime = System.nanoTime(); //End timing after the results are fetched
        double durationInSeconds = (endTime - startTime) / 1_000_000_000.0; //This converts nanoseconds to seconds
        System.out.printf("Similarity search took %.3f seconds.\n", durationInSeconds);
      }
    }
    catch (Exception exception) {
      throw new RuntimeException(exception);
    }
  }
}
</copy>
```
</br>

## Task 3: Review the ojdbc-vector-examples-cohere directory
Let's take a look at how this directory is configured. 

```
ai-vector-search-oracle-jdbc-examples-main
└── ojdbc-vector-examples-cohere
    └── src
        └── main
            └── java
                └── oracle
                    └── jdbc
                        └── vector
                            └── examples
                                └── cohere
```

</br>

### pom.xml within cohere
To begin, let's first edit the pom file within the `ojdbc-vector-examples-cohere` folder. The pom.xml file should look as followed:

```
<copy>
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc-vector-examples</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>ojdbc-vector-examples-cohere</artifactId>
    <version>1.0.0</version>

    <dependencies>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.15.1</version>
        </dependency>
        <dependency>
            <groupId>com.oracle.database.jdbc</groupId>
            <artifactId>ojdbc-vector-examples-common</artifactId>
            <version>1.0.0</version>
        </dependency>
        <dependency>
            <groupId>com.oracle.oci.sdk</groupId>
            <artifactId>oci-java-sdk-common-httpclient-jersey</artifactId>
            <version>3.41.0</version>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-simple</artifactId>
            <version>2.0.13</version>
        </dependency>
        <dependency>
            <groupId>com.oracle.oci.sdk</groupId>
            <artifactId>oci-java-sdk-common</artifactId>
            <version>3.41.0</version>
        </dependency>
        <dependency>
            <groupId>com.oracle.oci.sdk</groupId>
            <artifactId>oci-java-sdk-generativeaiinference</artifactId>
            <version>3.41.0</version>
        </dependency>
        <dependency>
            <groupId>org.json</groupId>
            <artifactId>json</artifactId>
            <version>20240303</version>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <id>oracle-public</id>
            <url>https://maven.oracle.com/public</url>
	    <layout>default</layout>
	    <releases>
	        <enabled>true</enabled>
	    </releases>
	    <snapshots>
		<enabled>false</enabled>
	    </snapshots>
        </repository>
    </repositories>
	
</project>
</copy>
```
</br>
  Now we shall proceed to the cohere folder. That folder shall be </br>
  **/ai-vector-search-oracle-jdbc-examples-main/ojdbc-vector-examples-cohere/src/main/java/oracle/jdbc/vector/examples/cohere**



### CohereModel.java
The first file within the Cohere folder, shall be **CohereModel.java**. This code defines the CohereModel class that implements the **Model** interface to generate vector embeddings for text using Oracle Cloud Infrastructures Generative AI Service. The class is initialized with an OCI client configured through client configuration and authentication details read from the configuration.properties file. The **embed** method processes input text in batches, sends requests to the OCI Generative AI Service to generate embeddings, and combines the results into a single 2D float array. The **parseResponse** method converts the embedding results from the service response into the required float array format for further use.


```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples.cohere;

// Import necessary OCI and Java utility classes
import com.oracle.bmc.ClientConfiguration;
import com.oracle.bmc.ConfigFileReader;
import com.oracle.bmc.auth.AuthenticationDetailsProvider;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.generativeaiinference.GenerativeAiInferenceClient;
import com.oracle.bmc.generativeaiinference.model.EmbedTextDetails;
import com.oracle.bmc.generativeaiinference.model.OnDemandServingMode;
import com.oracle.bmc.generativeaiinference.requests.EmbedTextRequest;
import com.oracle.bmc.generativeaiinference.responses.EmbedTextResponse;
import oracle.jdbc.vector.examples.Config;
import oracle.jdbc.vector.examples.Model;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * A model which is accessed through the OCI Generative AI Service.
 * This class implements the Model interface, providing a specific implementation embedding text using OCI's services.
 */
public class CohereModel implements Model {
    // Singleton instance of the model
    public static final Model INSTANCE = new CohereModel();
    private final AuthenticationDetailsProvider authentication;

    // Constructor for the CohereModel class
    public CohereModel() {
        try {
            // Initialize the authentication provider using OCI configuration file
            authentication = new ConfigFileAuthenticationDetailsProvider(
                ConfigFileReader.parse(Config.get("OCI_CONFIG_LOCATION"), Config.get("OCI_CONFIG_PROFILE"))
            );
        } catch (Exception e) {
            // Handle exceptions during initialization
            throw new RuntimeException("Failed to initialize the OCI Generative AI client", e);
        }
    }

    // Method to create and configure GenerativeAiInferenceClient
    private GenerativeAiInferenceClient createClient() {
        // Set up the client configuration with a custom read timeout
        ClientConfiguration clientConfiguration = ClientConfiguration.builder()
            .readTimeoutMillis(240000) // sets the read timeout to 240 seconds
            .build();
        // Create a client instance for generative AI inference with the configured provider and client configuration
        GenerativeAiInferenceClient generativeAiInferenceClient = new GenerativeAiInferenceClient(authentication, clientConfiguration);
        // Set the endpoint for the client
        generativeAiInferenceClient.setEndpoint(Config.get("OCI_ENDPOINT"));
        return generativeAiInferenceClient;
    }

    @Override
    public float[][] embed(String[] texts) {
        // Use try-with-resources to ensure the client is closed after use
        try (GenerativeAiInferenceClient client = createClient()) {
            List<String> inputs = Arrays.asList(texts);
            float[][] embeddings = new float[inputs.size()][];

            // Process in batches of up to 96 items
            int batchSize = 96;
            for (int start = 0; start < inputs.size(); start += batchSize) {
                int end = Math.min(inputs.size(), start + batchSize);
                List<String> batchInputs = inputs.subList(start, end);

                // Create EmbedTextDetails for the current batch
                EmbedTextDetails embedTextDetails = EmbedTextDetails.builder()
                    .servingMode(OnDemandServingMode.builder().modelId("cohere.embed-english-v3.0").build())
                    .compartmentId(Config.get("OCI_COMPARTMENT_ID"))
                    .inputs(batchInputs)
                    .build();

                // Create the EmbedTextRequest for the current batch
                EmbedTextRequest request = EmbedTextRequest.builder()
                    .embedTextDetails(embedTextDetails)
                    .build();

                // Get the response for the current batch
                EmbedTextResponse response = client.embedText(request);
                float[][] batchEmbeddings = parseResponse(response);

                // Combine batch embeddings into the main array
                System.arraycopy(batchEmbeddings, 0, embeddings, start, batchEmbeddings.length);
            }
            return embeddings;
        }
    }

    // Method to parse the EmbedTextResponse and convert it to a float[][] array
    private float[][] parseResponse(EmbedTextResponse response) {
        // Extract embeddings from the response
        List<List<Float>> embeddingsList = response.getEmbedTextResult().getEmbeddings();
        float[][] embeddings = new float[embeddingsList.size()][];
        for (int i = 0; i < embeddingsList.size(); i++) {
            List<Float> embeddingList = embeddingsList.get(i);
            embeddings[i] = new float[embeddingList.size()];
            // Convert each list of Float to a float array
            for (int j = 0; j < embeddingList.size(); j++) {
                embeddings[i][j] = embeddingList.get(j);
            }
        }
        // Return the parsed embeddings
        return embeddings;
    }
}

</copy>
```

### **CohereSimilaritySearch.java**
The final code within the cohere folder is a Java file named **`CohereSimilaritySearch.java`** . </br>
This will run an interactive similarity search using Oracle Database and the CohereModel for generating vector embeddings. The **main** method in this class calls the **run** method of the **SimilaritySearch** class, passing the singleton instance of **CohereModel** as an argument. This setup leverages the OCI Generative AI service to generate embeddings and execute similarity searches.

 ```
 <copy>
 /**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
 package oracle.jdbc.vector.examples.cohere;

import oracle.jdbc.vector.examples.SimilaritySearch;

/**
 * Runs an interactive similarity search using Oracle Database and
 * Oracle Generative AI Service.
 */
public class CohereSimilaritySearch {

  public static void main(String[] args) {
    SimilaritySearch.run(CohereModel.INSTANCE);
  }

}

 </copy>
 ```
</br>
This concludes all the files within the Cohere folder.
</br>

## Task 4: Review the ojdbc-vector-examples-openai directory

Let's take a look at how this directory is configured. 

```
ai-vector-search-oracle-jdbc-examples-main
└── ojdbc-vector-examples-openai
    └── src
        └── main
            └── java
                └── oracle
                    └── jdbc
                        └── vector
                            └── examples
                                └── openai
```
The openai folder shall contain 2 Java files, **`OpenAiModel.java`** and **`OpenAiSimilaritySearch.java`** .

### pom.xml within openai
Within the **/ai-vector-search-oracle-jdbc-examples-main/ojdbc-vector-examples-openai/** , let's see the pom.xml file.

```
<copy>
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc-vector-examples</artifactId>
        <version>1.0.0</version>
    </parent>

    <artifactId>ojdbc-vector-examples-openai</artifactId>
    <version>1.0.0</version>

    <dependencies>
        <dependency>
            <groupId>com.oracle.database.jdbc</groupId>
            <artifactId>ojdbc-vector-examples-common</artifactId>
            <version>1.0.0</version>
        </dependency>
        <dependency>
            <groupId>com.theokanning.openai-gpt3-java</groupId>
            <artifactId>service</artifactId>
            <version>0.18.2</version>
        </dependency>
    </dependencies>

</project>

</copy>
```

Now we will proceed to the OpenAi folder located at **ai-vector-search-oracle-jdbc-examples-main/ojdbc-vector-examples-openai/src/main/java/oracle/jdbc/vector/examples/openai**

### **OpenAiModel.java**
The first Java file is named `OpenAiModel.java`. This code defines an **`OpenAiModel`** class that implements the **`Model`** interface for generating vector embeddings of sentences using the OpenAi Service. The class is a singleton, ensuring only one instance exists and uses the community maintained OpenAi-Java client for interacting with the OpenAI API. The **`embed`** method constructs an embedding requests, sends it to the OpenAI service, and proceeses the response to convert embeddings into 2D float array. It includes error handling for rate limiting by waiting and retrying the request if the rate limit is exceeded.

This implementation uses the community maintained Java client for OpenAI: <"https://github.com/TheoKanning/openai-java/tree/main">

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples.openai;

import com.theokanning.openai.OpenAiHttpException;
import com.theokanning.openai.embedding.Embedding;
import com.theokanning.openai.embedding.EmbeddingRequest;
import oracle.jdbc.vector.examples.Config;
import oracle.jdbc.vector.examples.Model;
import com.theokanning.openai.service.OpenAiService;

import java.util.Arrays;
import java.util.List;

/**
 * A model implemented with OpenAI. This implementation uses the community
 * maintained Java client for OpenAI:
 * <a href="https://github.com/TheoKanning/openai-java/tree/main">
 * OpenAI-Java
 * </a>
 */
final class OpenAiModel implements Model {


  /** Singleton instance of this class */
  static final OpenAiModel INSTANCE = new OpenAiModel();
  private OpenAiModel() { }

  private static final OpenAiService SERVICE =
    new OpenAiService(Config.get("OPENAI_API_KEY"));

  @Override
  public float[][] embed(String[] sentences) {
    EmbeddingRequest request =
      EmbeddingRequest.builder()
        .input(Arrays.asList(sentences))
        .model(Config.getOrDefault("OPENAI_MODEL", "text-embedding-3-large"))
        .build();

    do {
      try {
        return SERVICE.createEmbeddings(request)
          .getData()
          .stream()
          .map(Embedding::getEmbedding)
          .map(OpenAiModel::toFloatArray)
          .toArray(float[][]::new);
      }
      catch (OpenAiHttpException httpException) {
        if (!"rate_limit_exceeded".equals(httpException.code))
          throw httpException;

        // A "rate_limit_exceeded" error means that too many requests have been
        // sent within a period of time. Recover from this by waiting.
        System.out.println(httpException.getMessage());
        try {
          for (int i = 20; i >= 0; i--) {
            System.out.print("Waiting " + i + " seconds...\r");
            Thread.sleep(1_000);
          }
        }
        catch (InterruptedException interruptedException) {
          System.out.println("Wait interrupted");
        }
      }
    } while (true);

  }

  private static float[] toFloatArray(List<Double> doubleList) {
    float[] floatArray = new float[doubleList.size()];

    for (int i = 0; i < floatArray.length; i++)
      floatArray[i] = doubleList.get(i).floatValue();

    return floatArray;
  }
}
</copy>
```

</br>

### OpenAiSimilaritySearch.java
The final Java file within the openai folder is **`OpenAiSimilaritySearch.java`**.</br>

This code defines an **`OpenAiSimilaritySearch`** class that performs an interactive similarity search using Oracle Database and the **`OpenAiModel`** for generating vector embeddings. The **`main`** method in this class calls the **`run`** method of the **`SimilaritySearch`** class, passing the singleton instance of **`OpenAiModel`** as an argument. This setup leverages the OpenAI service to generate embeddings and execute similarity searches.

```
<copy>
/**-----------------------------------------------------------------------------
 Copyright (c) 2023, Oracle and/or its affiliates.

 This software is dual-licensed to you under the Universal Permissive License
 (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
 either license.

 If you elect to accept the software under the Apache License, Version 2.0,
 the following applies:

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 -----------------------------------------------------------------------------
*/
package oracle.jdbc.vector.examples.openai;

import oracle.jdbc.vector.examples.SimilaritySearch;

/**
 * Runs an interactive similarity search using Oracle Database and
 * {@linkplain OpenAiModel OpenAI}. Please see the README.md for values that
 * must be configured to run this example.
 */
public class OpenAiSimilaritySearch {

  public static void main(String[] args) {
    SimilaritySearch.run(OpenAiModel.INSTANCE);
  }

}
</copy>
```
</br>

This concludes all the files we will need within this directory.

## Summary

In this lab we have gone through all the Java files which will be needed to run future labs. You are now ready to move onto the next lab.


## Learn More
* [Oracle Database 23ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/)
* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/)
* [Oracle Documentation](http://docs.oracle.com)
* [OpenAI.com](https://openai.com) 

## Acknowledgements
* **Author** - Francis Regalado, Cloud Solutions Engineer
* **Last Updated By/Date** - Francis Regalado, May 2024