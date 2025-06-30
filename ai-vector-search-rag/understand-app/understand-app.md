# Understand RAG Basic Example application

## Introduction

Estimated Time: 30 minutes.

### Objectives

In this lab, you will:

- Review APEX application SQL statement and PL/SQL code.
- Test some code snippets in APEX SQL Workshop > SQL Commands.
- Use Oracle Cloud Console > Database Actions if necessary to practice more.

Watch these videos for a quick demonstration of the main capabilities explained in this workshop:

[The database can help you organize documents](youtube:qhEtVaTFv1s)

[The database can help you search documents](youtube:Pr4oDiFYwrc)

[The database can help you classify documents](youtube:PwhYcEa67Q8)

[The database can help you convert documents](youtube:0NBj0T53mz0)

### Prerequisites

This lab assumes you have the following:
* Completed the previous labs of this workshop.
* Experience with Oracle Database features, SQL, and PL/SQL.
* Experience with Oracle APEX low-code development.


## Task 1: Review and understand the Home page

1. Look at the `P1_PROMPT` item SQL Query. It has a sub-query called `query_vector` that vectorizes the question written in item `P1_QUERY` using the same LLM. This vector is compared with the vectors stored in the `VECTORS` table and returns the first 5 results by distance. The contents of the closest 5 chunks is concatenanted and returned as `FINAL_PROMPT`.

    ````sql
    <copy>
    select  
    apex_string.join_clobs(apex_t_clob(listagg(replace(replace(CHUNK_CONTENTS, '''', '’'), '\', '\\'), ';'))) as FINAL_PROMPT
    from (
    with query_vector as (
                select TO_VECTOR(VECTOR_EMBEDDING(ALLMINL12V2 using :P1_QUERY as DATA)) as vector_embedding)
    select v.CHUNK_CONTENTS
    from VECTORS v, query_vector
    order by VECTOR_DISTANCE(v.VECTOR_EMBEDDING, query_vector.vector_embedding, COSINE)
    fetch first 5 rows ONLY);
    </copy>
    ````

2. The generative AI prompt is used to initiate a response from the AI system. It is a natural language question or statement that triggers the AI to generate a relevant and contextually appropriate response. This particular application uses a promp that has an XML structure, similar to this:

    ````sql
    <copy>
    <CONTEXT>
        Here goes the information used to answer the question based on the concatenation - listagg(CHUNK_CONTENTS, ';') - of the first 5 document chunks based on vector proximity.
        <QUESTION>
            Using the information from the previous context, answer the following question: Here goes the question - query_vector - to be answered.
        </QUESTION>
    </CONTEXT>
    </copy>
    ````

3. Review the code of the `P1_RESPONSE` item PL/SQL Function Body. This function builds the prompt `l_prompt` (also called prompt engineering) using the simple XML structure with two fields: `CONTEXT` and `QUESTION`. This prompt is used to create an API request to OCI Generative AI service with the body `l_body` using a simple JSON structure that specifies the parameters and the prompt. The response is captured in `l_resp` variable and also has a JSON structure. The `l_result` variable is used to process the fields in the response and extract the answer text. The information is inserted into the `CONVERSATION` table.

    ````sql
    <copy>
    declare
    l_body json_object_t;
    l_resp dbms_cloud_types.resp;
    l_context clob;
    l_question clob;
    l_prompt clob;
    l_result clob;
    begin
    l_context := replace(replace(replace(:P1_PROMPT, '"', '“'), chr(13), ''), chr(10), ' ');
    l_question := replace(replace(replace(:P1_QUERY, '"', '“'), chr(13), ''), chr(10), ' ');
    l_prompt := '<CONTEXT> ' || l_context || ' <QUESTION> Using the information from the previous context, answer the following question: ' || l_question || ' </QUESTION></CONTEXT>';
    l_body := json_object_t('{
    "compartmentId": "' || :COMPARTMENT_OCID || '",
    "servingMode": {
        "modelId": "cohere.command-r-plus-08-2024",
        "servingType": "ON_DEMAND"
    },
    "chatRequest": {
        "apiFormat": "COHERE",
        "maxTokens": 600,
        "message": "' || l_prompt || '"
    }
    }');
    l_resp := dbms_cloud.send_request(
        credential_name   => 'OCI_CREDENTIAL',
        uri => 'oci://inference.generativeai.' || :TENANCY_REGION || '.oci.oraclecloud.com/20231130/actions/chat',
        method => dbms_cloud.METHOD_POST,
        body => utl_raw.cast_to_raw(l_body.to_clob),
        headers => json_object('Accept' value 'application/json')
    );
    l_result := json_query(dbms_cloud.get_response_text(l_resp), '$.chatResponse.text');
    l_result := substr(l_result, 2, length(l_result) - 2);
    l_result := replace(replace(replace(l_result,'\n', chr(10)), '\t', ' '), '\"', '“');
    insert into CONVERSATION (APPUSER_ID, QUESTION, ANSWER, CREATED) 
        values (:AI_USER_ID, :P1_QUERY, l_result, SYSDATE);
    return(l_result); 
    end;
    </copy>
    ````

4. If you just want to test the API request to OCI Generative AI service from APEX SQL Workshop > SQL Commands, run the following code (check the chat request for Cohere models attributes in the 'Learn more' section at the bottom of this lab):

    ````sql
    <copy>
    declare
    body json_object_t;
    resp dbms_cloud_types.resp;
    result clob;
    begin
    body := json_object_t('{
    "compartmentId": "ocid1.compartment.oc1..aaaaaaaa_here_use_your_own_compartment_ocid",
    "servingMode": {
        "modelId": "cohere.command-r-plus-08-2024",
        "servingType": "ON_DEMAND"
    },
    "chatRequest": {
        "apiFormat": "COHERE",
        "maxTokens": 600,
        "message": "What are the most important new features of Oracle Database 23ai?"
    }
    }');
    resp := dbms_cloud.send_request(
        credential_name   => 'OCI_CREDENTIAL',
        uri => 'oci://inference.generativeai.uk-london-1.oci.oraclecloud.com/20231130/actions/chat',
        method => dbms_cloud.METHOD_POST,
        body => utl_raw.cast_to_raw(body.to_clob),
        headers => json_object('Accept' value 'application/json')
    );
    result := json_query(dbms_cloud.get_response_text(resp), '$.chatResponse.text');
    dbms_output.put_line(result);
    end;
    /
    </copy>
    ````

5. If you want to test an API request to OCI Generative AI service with a specific prompt, run the following code:

    ````sql
    <copy>
    declare
    l_body json_object_t;
    l_resp dbms_cloud_types.resp;
    l_context clob;
    l_question clob;
    l_prompt clob;
    l_result clob;
    P1_PROMPT clob := 'Here you can add the context for the prompt, all the
    information you want to include,
    it can be on multiple lines.';
    P1_QUERY clob := 'What are the most important new features of Oracle Database 23ai?';
    COMPARTMENT_OCID varchar2(100) := 'ocid1.compartment.oc1..aaaaaaaa_here_use_your_own_compartment_ocid';
    TENANCY_REGION varchar2(20) := 'uk-london-1';
    begin
    l_context := replace(replace(replace(P1_PROMPT, '"', '“'), chr(13), ''), chr(10), ' ');
    l_question := replace(replace(replace(P1_QUERY, '"', '“'), chr(13), ''), chr(10), ' ');
    l_prompt := '<CONTEXT> ' || l_context || ' <QUESTION> Using the information from the previous context, answer the following question: ' || l_question || ' </QUESTION></CONTEXT>';
    l_body := json_object_t('{
    "compartmentId": "' || COMPARTMENT_OCID || '",
    "servingMode": {
        "modelId": "cohere.command-r-plus-08-2024",
        "servingType": "ON_DEMAND"
    },
    "chatRequest": {
        "apiFormat": "COHERE",
        "maxTokens": 600,
        "message": "' || l_prompt || '"
    }
    }');
    l_resp := dbms_cloud.send_request(
        credential_name   => 'OCI_CREDENTIAL',
        uri => 'oci://inference.generativeai.' || TENANCY_REGION || '.oci.oraclecloud.com/20231130/actions/chat',
        method => dbms_cloud.METHOD_POST,
        body => utl_raw.cast_to_raw(l_body.to_clob),
        headers => json_object('Accept' value 'application/json')
    );
    l_result := json_query(dbms_cloud.get_response_text(l_resp), '$.chatResponse.text');
    l_result := substr(l_result, 2, length(l_result) - 2);
    l_result := replace(replace(replace(l_result,'\n', chr(10)), '\t', ' '), '\"', '“');
    dbms_output.put_line(l_result);
    end;
    </copy>
    ````

6. All questions submitted and answered stored in the historical `CONVERSATION` table are listed in the `Conversation` report using this SQL Query.

    ````sql
    <copy>
    select QUESTION, ANSWER, CREATED from CONVERSATION
    where APPUSER_ID = :AI_USER_ID
    </copy>
    ````


## Task 2: Review and understand the Test page

1. This page is simiar to the Home page except it displays the top 5 chunks that are used to build the prompt. The `P3000_PROMPT` item SQL Query is the same as the one on the Home page.

    ````sql
    <copy>
    select  
    apex_string.join_clobs(apex_t_clob(listagg(replace(replace(CHUNK_CONTENTS, '''', '’'), '\', '\\'), ';'))) as FINAL_PROMPT
    from (
    with query_vector as (
                select TO_VECTOR(VECTOR_EMBEDDING(ALLMINL12V2 using :P3000_QUERY as DATA)) as vector_embedding)
    select replace(replace(replace(replace(v.CHUNK_CONTENTS, '"', '“'), chr(13), ''), chr(10), ' '), '\', '\\') as CHUNK_CONTENTS
    from VECTORS v, query_vector
    order by VECTOR_DISTANCE(v.VECTOR_EMBEDDING, query_vector.vector_embedding, COSINE)
    fetch first 5 rows ONLY);
    </copy>
    ````


2. The `P3000_RESPONSE` item PL/SQL Function Body is the same as the one on the Home page.

    ````sql
    <copy>
    declare
    l_body json_object_t;
    l_resp dbms_cloud_types.resp;
    l_context clob;
    l_question clob;
    l_prompt clob;
    l_result clob;
    begin
    l_context := replace(:P3000_PROMPT, chr(10), ' ');
    l_question := replace(replace(replace(:P3000_QUERY, '"', '“'), chr(13), ''), chr(10), ' ');
    l_prompt := '<CONTEXT> ' || l_context || ' <QUESTION> Using the information from the previous context, answer the following question: ' || l_question || ' </QUESTION></CONTEXT>';
    l_body := json_object_t('{
    "compartmentId": "' || :COMPARTMENT_OCID || '",
    "servingMode": {
        "modelId": "cohere.command-r-plus-08-2024",
        "servingType": "ON_DEMAND"
    },
    "chatRequest": {
        "apiFormat": "COHERE",
        "maxTokens": 600,
        "message": "' || l_prompt || '"
    }
    }');
    l_resp := dbms_cloud.send_request(
        credential_name   => 'OCI_CREDENTIAL',
        uri => 'oci://inference.generativeai.' || :TENANCY_REGION || '.oci.oraclecloud.com/20231130/actions/chat',
        method => dbms_cloud.METHOD_POST,
        body => utl_raw.cast_to_raw(l_body.to_clob),
        headers => json_object('Accept' value 'application/json')
    );
    l_result := json_query(dbms_cloud.get_response_text(l_resp), '$.chatResponse.text');
    l_result := substr(l_result, 2, length(l_result) - 2);
    l_result := replace(replace(replace(l_result,'\n', chr(10)), '\t', ' '), '\"', '“');
    insert into CONVERSATION (APPUSER_ID, QUESTION, ANSWER, CREATED) values (:AI_USER_ID, :P3000_QUERY, l_result, SYSDATE);
    return(l_result); 
    end;
    </copy>
    ````


3. The `Proximity Vectors` report lists the first 5 chunks that are closer to the question based on their vector distance value using this SQL Query:

    ````sql
    <copy>
    with query_vector as (
                select TO_VECTOR(VECTOR_EMBEDDING(ALLMINL12V2 using :P3000_QUERY as DATA)) as vector_embedding)
    select v.BLOBDOC_ID, v.CHUNK_NO, v.CHUNK_CONTENTS
    from VECTORS v, query_vector
    order by VECTOR_DISTANCE(v.VECTOR_EMBEDDING, query_vector.vector_embedding, COSINE)
    fetch first 5 rows ONLY;
    </copy>
    ````


## Task 3: Review and understand the Upload page

1. The Upload page is used to send documents from your computer to the OCI Object Storage bucket. Review the `Upload` process PL/SQL Code that uses a REST API `PUT` request to perform the operation. The table `OBJSDOCS` is used to keep track of the documents uploaded and available in the Object Storage bucket. If the same document has been uploaded before, the previous record is removed from the table, as the file is overwritten. A record in inserted into the `OBJSDOCS` table for the uploaded document.

    ````sql
    <copy>
    declare
        l_user_id number;
        l_request_url varchar(32000);
        l_response clob;
        l_request_object blob;
        l_request_filename varchar2(500);
    begin
        select ID into l_user_id from APPUSER where lower(EMAIL) = lower(NVL(SYS_CONTEXT('APEX$SESSION','APP_USER'),user));
        select blob_content, filename into l_request_object, l_request_filename from apex_application_temp_files where name = :P200_FILE_NAME;
        l_request_url := 'https://' || :TENANCY_NAME || '.objectstorage.' || :TENANCY_REGION || '.oci.customer-oci.com/n/' || :TENANCY_NAME || '/b/DBAI-bucket/o/' || 
                        apex_util.url_encode(l_request_filename);        
        l_response := apex_web_service.make_rest_request(
            p_url => l_request_url,
            p_http_method => 'PUT',
            p_body_blob => l_request_object,
            p_credential_static_id => 'OBJAPI'
        );
        delete from OBJSDOCS where FILE_NAME = replace(l_request_filename, ' ', '+');
        insert into OBJSDOCS (FILE_NAME, CREATED, CREATED_BY) 
            values (replace(l_request_filename, ' ', '+'), SYSDATE, l_user_id);
    end;
    </copy>
    ````

2. The `Object Storage` classic report retrieves the list of documents stored in your Object Storage bucker using the following SQL Query:

    ````sql
    <copy>
    select od.ID, lo.OBJECT_NAME, lo.BYTES, lo.LAST_MODIFIED, od.CREATED_BY
    from dbms_cloud.list_objects('OBJS_CREDENTIAL',
    'https://' || :TENANCY_NAME || '.objectstorage.' || :TENANCY_REGION || '.oci.customer-oci.com/n/' || :TENANCY_NAME || '/b/DBAI-bucket/o/') lo
    left join OBJSDOCS od on lo.OBJECT_NAME = od.FILE_NAME
    where upper(lo.OBJECT_NAME) not like '%.ONNX';
    </copy>
    ````

3. This is actually the same query used to list objects in your Object Storage Bucket with a join on `OBJSDOCS` table for additional metadata fields.

    ````sql
    <copy>
    select * from dbms_cloud.list_objects('OBJS_CREDENTIAL','https://YourObjStorageNamespace.objectstorage.uk-london-1.oci.customer-oci.com/n/YourObjStorageNamespace/b/DBAI-bucket/o/');
    </copy>
    ````


## Task 4: Review and understand the Docs page

1. Review the `Import` process PL/SQL Code. It reads the first 32400 bytes of the document from the Object Storage bucket into the `doc_file` variable. Then, it reads the rest of the file in segments (parts) of 32400 bytes each, and appends them to the same `doc_file` variable. Once it has the entire document, it stores it as a BLOB into the `BLOBDOCS` table. At the end, it performs some clean-up operations for vectors that have been removed from the `VECTORS` table and documents that have been deleted from the `OBJSDOCS` table.

    ````sql
    <copy>
    DECLARE
        doc_file    BLOB default EMPTY_BLOB();
        doc_part    BLOB default EMPTY_BLOB();
        doc_uri     VARCHAR2(250) := 'https://' || :TENANCY_NAME || '.objectstorage.' || :TENANCY_REGION || '.oci.customer-oci.com/n/' || :TENANCY_NAME || '/b/DBAI-bucket/o/';
        status      NUMBER default 1;
        part_number NUMBER default 1;
        doc_id      NUMBER;
    BEGIN
        select ID into doc_id from OBJSDOCS where FILE_NAME = :P101_FILE_NAME;
        -- Read file from Object Storage
        SELECT to_blob(dbms_cloud.get_object(
            credential_name => 'OBJS_CREDENTIAL',
            object_uri => doc_uri || :P101_FILE_NAME,
            startOffset => 0,
            endOffset => 32400-1
        )) into doc_file; 
        WHILE status = 1
        LOOP
            -- Read each file part
            SELECT to_blob(dbms_cloud.get_object(
                credential_name => 'OBJS_CREDENTIAL',
                    object_uri => doc_uri || :P101_FILE_NAME,
                startOffset => (32400*part_number),
                endOffset => (32400*(part_number+1)-1)
            )) into doc_part;
            part_number := part_number + 1;
            -- Finish loop when no more parts
            IF dbms_lob.getlength(doc_part) is NULL THEN
                status := 0;
            ELSE
                -- Append part to blob and show current size
                dbms_lob.append(doc_file, doc_part);
            END IF;
        END LOOP; 
        insert into BLOBDOCS (OBJSDOC_ID, DOC_DATA) values (doc_id, doc_file);
        -- clean orphan docs from tables
        delete from VECTORS where ID in (
        select v.ID from VECTORS v 
            left join BLOBDOCS b on b.ID = v.BLOBDOC_ID
            left join OBJSDOCS o on o.ID = b.OBJSDOC_ID
        where o.ID is NULL );
        delete from BLOBDOCS where ID in (
        select b.ID from BLOBDOCS b 
            left join OBJSDOCS o on o.ID = b.OBJSDOC_ID
        where o.ID is NULL );
        COMMIT;
    END;
    </copy>
    ````


2. Check the `Imported Documents` interactive report SQL Query that lists all the documents that have been imported as BLOBs into the database `BLOBDOCS` table. It is easier, faster, and more secure to process files inside the database than reading always from the Object Storage bucket.

    ````sql
    <copy>
    select b.ID, o.FILE_NAME, o.CREATED, o.CREATED_BY, length(b.DOC_DATA) Data
    from BLOBDOCS b left join OBJSDOCS o on o.ID = b.OBJSDOC_ID
    where o.CREATED is not NULL
    </copy>
    ````

3. Write down in your notes the ID of one document that was imported into the `BLOBDOCS` table for some tests (`BLOBDOCS.ID` column). Call it `TEST_DOC_ID`.

    ````sql
    <copy>
    select b.ID, o.FILE_NAME
    from BLOBDOCS b left join OBJSDOCS o on o.ID = b.OBJSDOC_ID
    where o.CREATED is not NULL
    </copy>
    ````


## Task 5: Review and understand the Vectors page

1. Read, understand, and customize the `Vectorize` process PL/SQL Code to fully understand how this process works. There are multiple ways of creating embeddings (vectorize) your data inside the Oracle Database 23ai, please check the documentation links at the end of this lab for the complete set of details. The SQL query used to generate the embeddings (with JSON format), used to extract the necessary fields (`EMBED_ID`, `EMBED_DATA`, and `EMBED_VECTOR`) inserted into the `VECTORS` table, has three procedures executed in cascade:

    * `DBMS_VECTOR_CHAIN.utl_to_text` subprogram extracts plain text data from documents. The BLOB document is used as input.
    * `DBMS_VECTOR_CHAIN.utl_to_chunks` utility function splits data into smaller pieces or chunks. Input parameters are specified in JSON format.
    * `DBMS_VECTOR_CHAIN.utl_to_embeddings` chainable utility function converts data to vector embeddings. You can perform a text-to-embedding transformation by accessing either Oracle Database or a third-party service provider. In this example, Oracle Database is the service provider using the imported LLM model `ALLMINL12V2`.

    ````sql
    <copy>
    insert into VECTORS (BLOBDOC_ID, CHUNK_NO, CHUNK_CONTENTS, VECTOR_EMBEDDING)
    select b.ID, et.EMBED_ID, et.EMBED_DATA, to_vector(et.EMBED_VECTOR) EMBED_VECTOR
        from BLOBDOCS b, OBJSDOCS o,
            DBMS_VECTOR_CHAIN.utl_to_embeddings(
              DBMS_VECTOR_CHAIN.utl_to_chunks(
                DBMS_VECTOR_CHAIN.utl_to_text(b.DOC_DATA),
                json('{ "split":"sentence",
                        "max":"410",
                        "overlap":"25",
                        "language":"english",
                        "normalize":"all" }')),
              json('{"provider":"database", "model":"ALLMINL12V2"}')) t,
            json_table(t.column_value, '$[*]' columns (
                embed_id number path '$.embed_id', 
                embed_data varchar2(4000) path '$.embed_data',
                embed_vector clob path '$.embed_vector')) et
    where o.ID = b.OBJSDOC_ID and b.ID = :P300_FILE_NAME;
    </copy>
    ````

2. Use APEX SQL Workshop > SQL Commands to test different embedding operations by changing the parameters of the `DBMS_VECTOR_CHAIN.utl_to_chunks` utility function. Check the `DBMS_VECTOR_CHAIN` PL/SQL Package Reference documentation link at the bottom of this lab.

    ````sql
    <copy>
    select b.ID, et.EMBED_ID, et.EMBED_DATA, to_vector(et.EMBED_VECTOR) EMBED_VECTOR
        from BLOBDOCS b,
            DBMS_VECTOR_CHAIN.utl_to_embeddings(
              DBMS_VECTOR_CHAIN.utl_to_chunks(
                DBMS_VECTOR_CHAIN.utl_to_text(b.DOC_DATA),
                json('{ "max":"210",
                        "overlap":"15",
                        "language":"english",
                        "normalize":"all" }')),
              json('{"provider":"database", "model":"ALLMINL12V2"}')) t,
            json_table(t.column_value, '$[*]' columns (
                embed_id number path '$.embed_id', 
                embed_data varchar2(4000) path '$.embed_data',
                embed_vector clob path '$.embed_vector')) et
    where b.ID = TEST_DOC_ID;
    </copy>
    ````

3. The plain text extracted from PDF documents can be processed in multiple ways. Read the `ChunkLines` process PL/SQL Code to see another example of reading data from the PDF document, converting it to HTML code, and extracting all paragraphs as individual lines. The chunk lines are stored in the `CHUNKLINES` table. This data can be further processed with Oracle Text or Graph, or you can use Oracle Machine Learning to classify these lines by their contents and label them with different categories. This way, you can eliminate noise from the text documents data, perform aditional filtering, extract metadata from specific fields like title, author, headers, footers, etc.

    ````sql
    <copy>
    insert into CHUNKLINES (BLOBDOC_ID, CHUNK_NO, LINE_NO, LINE_CONTENTS)
    with xml_tab as (select CHUNK_NO, xmltype('<html>' || replace(apex_markdown.to_html(b.CHUNK_CONTENTS),'<br />',' ') || '</html>') html_text
                    from VECTORS b where BLOBDOC_ID = :P300_FILE_NAME order by CHUNK_NO) 
    SELECT :P300_FILE_NAME as BLOBDOC_ID, x.CHUNK_NO, rownum, xt.paragraph
    FROM   xml_tab x,
        XMLTABLE('/html/p'
            PASSING x.html_text
            COLUMNS 
            paragraph VARCHAR2(4000) PATH '.'
            ) xt;
    </copy>
    ````

4. Use the `Embedded Documents` report SQL Query to list all documents that have been vectorized and the number of vectors (chunks) each one of them has.

    ````sql
    <copy>
    select b.ID, o.FILE_NAME, o.CREATED, o.CREATED_BY, count(v.ID) Vectors
    from VECTORS v left join BLOBDOCS b on b.ID = v.BLOBDOC_ID
    left join OBJSDOCS o on o.ID = b.OBJSDOC_ID
    group by b.ID, o.FILE_NAME, o.CREATED, o.CREATED_BY
    </copy>
    ````

## Task 6: Review and understand the Chunks and Chunk lines pages

1. Check the `Chunks` report SQL Query that returns all chunks and their contents for a specific document.

    ````sql
    <copy>
    select ID, BLOBDOC_ID, CHUNK_NO, CHUNK_CONTENTS 
    from VECTORS
    where BLOBDOC_ID = :P4_VBLOBDOC_ID
    </copy>
    ````


2. Review the `Chunk Lines` report SQL Query that returns the paragraphs of a single chunk as individual lines stored in the `CHUNKLINES` table. The `LINE_TYPE` could be used to classify each line with predefined labes like: title, author, link, index, header, footer, etc.

    ````sql
    <copy>
    select ID, BLOBDOC_ID, CHUNK_NO, LINE_NO, LINE_CONTENTS, LINE_TYPE 
    from CHUNKLINES 
    where BLOBDOC_ID = :P5_BLOBDOC_ID and CHUNK_NO = :P5_CHUNK_NO;
    </copy>
    ````

3. Use APEX SQL Workshop > SQL Commands to list the lines of the first chunk of the test document.

    ````sql
    <copy>
    select ID, BLOBDOC_ID, CHUNK_NO, LINE_NO, LINE_CONTENTS, LINE_TYPE 
    from CHUNKLINES 
    where BLOBDOC_ID = TEST_DOC_ID and CHUNK_NO = 1;
    </copy>
    ````

You may now **proceed to the next lab**.


## Learn More

* [Generative AI Service](https://www.oracle.com/artificial-intelligence/generative-ai/generative-ai-service/)
* [Oracle AI Vector Search User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/whats-new-oracle-ai-vector-search.html)
* [DBMS_VECTOR_CHAIN PL/SQL Package Reference](https://docs.oracle.com/en/database/oracle/oracle-database/23/arpls/dbms_vector_chain1.html)
* [DBMS_CLOUD PL/SQL Package Reference](https://docs.oracle.com/en/database/oracle/oracle-database/23/arpls/dbms_cloud.html)
* [VECTOR_DISTANCE SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/vector_distance.html)
* [APEX_WEB_SERVICE API Reference](https://docs.oracle.com/en/database/oracle/apex/24.2/aeapi/APEX_WEB_SERVICE.html)
* [SQL/JSON Function JSON_TABLE](https://docs.oracle.com/en/database/oracle/oracle-database/23/adjsn/sql-json-function-json_table.html)
* [CohereChatRequest Reference](https://docs.oracle.com/en-us/iaas/api/#/en/generative-ai-inference/20231130/datatypes/CohereChatRequest)

## **Acknowledgements**

- **Author** - Valentin Leonard Tabacaru, Database Product Management
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Database Product Management, March 2025
