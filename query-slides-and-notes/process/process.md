# Process JSON files in collections

## Introduction

Oracle

This lab explains how to

Estimated Time: 60 minutes

### Objectives

In this lab you will:
* Install

### Prerequisites

This lab assumes you have:
* Provisioned

## Task 1: Create collections and cleanup procedure

1. All JSON files can be imported into Autonomous JSON Database into collections. For this example, you will import only slides and notes content. Write a procedure to create the required collections. This procedure can be used for cleaning up all JSON documents and start importing them again from the beginning. Click **Run Script** button or F5.

    ````
    <copy>
    create or replace PROCEDURE CLEANUP_PPTX AUTHID CURRENT_USER IS
        status NUMBER;
        new_collection SODA_Collection_T;
    BEGIN
    	-- Drop all Collections
    	status := DBMS_SODA.DROP_COLLECTION('PPJSON',TRUE,TRUE);
    	status := DBMS_SODA.DROP_COLLECTION('notesSlides',TRUE,TRUE);
    	status := DBMS_SODA.DROP_COLLECTION('SLIDES',TRUE,TRUE);
    	-- Create all Collections
      -- 'PPJSON' collection is used to store the structure of the presentation in JSON format
    	new_collection := DBMS_SODA.CREATE_COLLECTION('PPJSON');
      -- 'notesSlides' is used to store notes content
    	new_collection := DBMS_SODA.CREATE_COLLECTION('notesSlides');
      -- 'SLIDES' collection is used to store slides content
    	new_collection := DBMS_SODA.CREATE_COLLECTION('SLIDES');
    	execute immediate 'truncate table PPTX_DONE';
    	commit;
    	-- Create search indexes for each collection
    	execute immediate 'CREATE SEARCH INDEX ppjson_search_idx ON ppjson (json_document) FOR JSON';
    	DBMS_STATS.gather_table_stats(USER, 'ppjson');
    	execute immediate 'CREATE SEARCH INDEX notesSlides_search_idx ON "notesSlides" (json_document) FOR JSON';
    	DBMS_STATS.gather_table_stats(USER, '"notesSlides"');
    	execute immediate 'CREATE SEARCH INDEX SLIDES_search_idx ON "SLIDES" (json_document) FOR JSON';
    	DBMS_STATS.gather_table_stats(USER, '"SLIDES"');
    END cleanup_pptx;
    /
    </copy>
    ````

2. Execute this cleanup procedure to create the collections and indexes.

    ````
    <copy>
    exec CLEANUP_PPTX;
    </copy>
    ````

## Task 2: Write and run document processing procedure

1. This procedure will import JSON documents into collections. It uses the presentation name as the input parameter. Click **Run Script** button or F5.

    ````
    <copy>
    create or replace PROCEDURE PROCESS_PPTX (p_pptx_name IN VARCHAR2) AUTHID CURRENT_USER IS
      oci_bucket VARCHAR2(128) default 'https://swiftobjectstorage.<region>.oraclecloud.com/v1/<tenancy>/LLXXX-JSON/';
      l_json_file VARCHAR2(255);
      l_check NUMBER;
      l_ppjson CLOB default '{';
      l_id VARCHAR2(255);
      n_collection SODA_COLLECTION_T;
      n_document SODA_DOCUMENT_T;
      n_status NUMBER default 1;
    BEGIN
      dbms_output.put_line('Processing presentation ' || p_pptx_name);

      -- verify if the presentation was already processed
      select count(*) into l_check from PPTX_DONE where PPTX_NAME = p_pptx_name;
      IF l_check > 0 THEN
        dbms_output.put_line('Presentation already exists');
      ELSE
        -- initialize presentation JSON structure
        l_ppjson := l_ppjson || '"pptx_name": "' || p_pptx_name || '", "files": [';

        -- import all notes into notesSlides collection
        FOR record IN (select * from JSON_FILES where FILE_NAME like p_pptx_name || '%/ppt/notesSlides/notesSlide%')
        LOOP
            dbms_output.put_line('notesSlides file ' || oci_bucket || record.FILE_NAME);
            dbms_cloud.copy_collection(    
                collection_name => 'notesSlides',
                credential_name => 'CLOUD_CREDENTIAL',      
                file_uri_list => oci_bucket || utl_url.escape(url => record.FILE_NAME),
                format => '{"recorddelimiter" : "0x''01''", "maxdocsize" : "100000000"}'
                );
            select ID into l_id from "notesSlides" order by CREATED_ON desc fetch first 1 rows only;
            l_ppjson := l_ppjson || '{"json_id": "' || l_id || '","collection": "notesSlides","file_name": "' || utl_url.escape(url => record.FILE_NAME) || '"},';
        END LOOP;

        -- import all slides into SLIDES collection
        FOR record IN (select * from JSON_FILES where FILE_NAME like p_pptx_name || '%/ppt/slides/slide%')
        LOOP
            dbms_output.put_line('SLIDES file ' || oci_bucket || record.FILE_NAME);
            dbms_cloud.copy_collection(    
                collection_name => 'SLIDES',
                credential_name => 'CLOUD_CREDENTIAL',      
                file_uri_list => oci_bucket || utl_url.escape(url => record.FILE_NAME),
                format => '{"recorddelimiter" : "0x''01''", "maxdocsize" : "100000000"}'
                );
            select ID into l_id from "SLIDES" order by CREATED_ON desc fetch first 1 rows only;
            l_ppjson := l_ppjson || '{"json_id": "' || l_id || '","collection": "SLIDES","file_name": "' || utl_url.escape(url => record.FILE_NAME) || '"},';
        END LOOP;

        l_ppjson := rtrim(l_ppjson, ',');
        l_ppjson := l_ppjson || ' ] }';
        dbms_output.put_line('PPJSON: ' || l_ppjson);

        -- insert presentation JSON structure into PPJSON collection
        n_collection := DBMS_SODA.open_collection('PPJSON');
        n_document := SODA_DOCUMENT_T(b_content => utl_raw.cast_to_raw(l_ppjson));
        n_status := n_collection.insert_one(n_document);

        -- insert processed presentation details into PPTX_DONE table
        insert into PPTX_DONE(PPTX_NAME, PROCESSED) values (p_pptx_name, sysdate);
        commit;
      END IF;    
    END process_pptx;
    /
    </copy>
    ````

2. Query view V_PPTX_DONE and get the presentation name (PPTX_NAME) with PPTX_DONE and PROCESSED columns with NULL values. This is a presentation that wasn't processed.

    ````
    <copy>
    select * from V_PPTX_DONE;
    </copy>
    ````

3. Execute process_pptx for the unprocessed presentation.

    ````
    <copy>
    exec process_pptx('<presentation name>');
    </copy>
    ````


## Task 3: Create presentation structure, slides and notes views

1. Create a view on PPJSON collection used to store the structure of the presentation in JSON format. This view provides a relational representation of the slides and notes in your presentations.

    ````
    <copy>
    create or replace editionable view V_PPJSON as
      select d.ID as ppt_json_id, j.*,
           substr(j.file_name, instr(j.file_name, '/', -1)+1, instr(j.file_name,'.',-1)-instr(j.file_name,'/',-1)-1) as short_name
        from PPJSON d, json_table (
             d.JSON_DOCUMENT, '$' columns (
               pptx_name path '$.pptx_name',
               nested path '$.files[*]'
               columns (
                 json_id path '$.json_id',
                 collection  path '$.collection',
    			 file_name  path '$.file_name'
           ) ) ) j;
    </copy>
    ````

2. PowerPoint stores slides content in multiple fields. You can use JSON data guide to identify those fields and retrieve their values in a table. The easiest way to build this table is using a SQL Macros function. Use **Run Script** button or F5 to create this function.

    ````
    <copy>
    create or replace function slides_content
                RETURN clob SQL_MACRO(TABLE) IS
      query_part VARCHAR2(16000);
    BEGIN
      select listagg(content_part, ', ') within group (order by ROWNUM) into query_part
        from (SELECT ' sl.JSON_DOCUMENT.' || substr(path, 3) || ' as content' || to_char(ROWNUM) as content_part
              FROM   user_json_dataguide_fields
              WHERE  table_name  = 'SLIDES'
              AND    column_name = 'JSON_DOCUMENT'
              AND	 path like '%"a:t"');
      query_part := 'SELECT sl.ID as slide_id, ' || query_part || ' FROM SLIDES sl';
      RETURN query_part;
    END slides_content;
    /
    </copy>
    ````

3. Query the SQL Macros function like a standard table to retrieve the contents of the slides.

    ````
    <copy>
    SELECT * FROM slides_content();
    </copy>
    ````

4. Use **Run Script** button or F5 to create the second SQL Macros function that retrieves the content of the notes.

    ````
    <copy>
    create or replace function slides_notes
                RETURN clob SQL_MACRO(TABLE) IS
      query_part VARCHAR2(16000);
    BEGIN
      select listagg(content_part, ', ') within group (order by ROWNUM) into query_part
        from (SELECT ' sn.JSON_DOCUMENT.' || substr(path, 3) || ' as content' || to_char(ROWNUM) as content_part
              FROM   user_json_dataguide_fields
              WHERE  table_name  = 'notesSlides'
              AND    column_name = 'JSON_DOCUMENT'
              AND	 path like '%"a:t"');
      query_part := 'SELECT sn.ID as note_id, ' || query_part || ' FROM "notesSlides" sn';
      RETURN query_part;
    END slides_notes;
    /
    </copy>
    ````

5. Query the SQL Macros function like a standard table to retrieve the contents of the notes.

    ````
    <copy>
    SELECT * FROM slides_notes();
    </copy>
    ````

6. Create a view that joins the structure of the presentation with the content of the slides. This will be used to organize the slides content by document.

    ````
    <copy>
    create or replace editionable view V_SLIDES_CONTENT as
    select s.ppt_json_id, s.pptx_name, s.file_name, s.short_name, sc.* from slides_content() sc
       left join (select * from V_PPJSON where COLLECTION = 'SLIDES') s
         on sc.slide_id = s.JSON_ID;
    </copy>
    ````

7. Retrieve slides content fields organized by slide document and presentation.

    ````
    <copy>
    select * from V_SLIDES_CONTENT;
    </copy>
    ````

8. Create a view that joins the structure of the presentation with the content of the notes. This will be used to organize the notes content by document.

    ````
    <copy>
    create or replace editionable view V_SLIDES_NOTES as
    select n.ppt_json_id, n.pptx_name, n.file_name, n.short_name, sn.* from slides_notes() sn
       left join (select * from V_PPJSON where COLLECTION = 'notesSlides') n
         on sn.note_id = n.JSON_ID;
    </copy>
    ````

9. Retrieve notes content fields organized by notes document and presentation.

    ````
    <copy>
    select * from V_SLIDES_NOTES;
    </copy>
    ````

10. Slide contents are retrieved by the SQL Macros as JSON array literals distributed across multiple columns. Use a view to consolidate these fragments into a single text column.

    ````
    <copy>
    create or replace editionable view V_SLIDES_TEXT as
    select PPT_JSON_ID, SLIDE_ID, PPTX_NAME, to_number(substr(SHORT_NAME, 6)) as slide#,
     replace(rtrim(ltrim(replace(replace(replace(replace(CONTENT1,'null,',''),'\"','|||'),'",',' '),' "',' '),'["'),'"]'),'|||','"') ||
     ' ' || rtrim(ltrim(replace(CONTENT3,'","',' '),'["'),'"]') || ' ' ||
     rtrim(ltrim(replace(CONTENT4,'","',' '),'["'),'"]') || ' ' ||
     rtrim(ltrim(replace(CONTENT5,'","',' '),'["'),'"]') || ' ' ||
     rtrim(ltrim(replace(CONTENT6,'","',' '),'["'),'"]') as SLIDE_TEXT
     from V_SLIDES_CONTENT
     order by PPT_JSON_ID, slide#;
    </copy>
    ````

11. Note contents are retrieved by the SQL Macros as JSON array literals distributed across multiple columns. Use a view to consolidate these fragments into a single text column.

    ````
    <copy>
    create or replace editionable view V_NOTES_TEXT as
    select PPT_JSON_ID, NOTE_ID, PPTX_NAME,
     CASE
      WHEN substr(CONTENT2,1,1) = '[' THEN to_number(substr(rtrim(CONTENT2,'"]'),instr(rtrim(CONTENT2,'"]'), '"', -1)+1))
      ELSE to_number(CONTENT2)
     END slide#,
     replace(rtrim(ltrim(replace(replace(replace(replace(CONTENT1,'null,',''),'\"','|||'),'",',' '),' "',' '),'["'),'"]'),'|||','"') as NOTE_TEXT
     from V_SLIDES_NOTES
     where CONTENT1 is not NULL
     order by PPT_JSON_ID, slide#;
    </copy>
    ````

12. Query the slide number and slide text in your presentation.

    ````
    <copy>
    select SLIDE#, SLIDE_TEXT from V_SLIDES_TEXT;
    </copy>
    ````

13. Query the slide number and note text in your presentation.

    ````
    <copy>
    select SLIDE#, NOTE_TEXT from V_NOTES_TEXT;
    </copy>
    ````


## Task 4: Conclusions and workflow summary

>**Note** : After creating all these scripts, procedures and views, you can add more presentations in 6 simple steps.

1. Upload PPTX presentation file into LLXXX-PPTX bucket.

2. Execute the unprocessed presentations listing procedure.

    ````
    <copy>
    exec to_process_csv;
    </copy>
    ````

3. Use the SSH connection to the LLXXX-VM compute instance to run the conversion script in LLPPTX-JSON folder.

    ````
    <copy>
    ./convert2json.sh
    </copy>
    ````

4. Select unprocessed presentation name from V_PPTX_DONE view, that has been converted to JSON but not imported into the Autonomous Database.

    ````
    <copy>
    select PPTX_NAME from V_PPTX_DONE where JSON_DONE is not NULL and PROCESSED is NULL;
    </copy>
    ````

5. Execute the procedure that imports JSON documents into collections, using the presentation name from previous step as the input parameter.

    ````
    <copy>
    exec process_pptx('<presentation name>');
    </copy>
    ````

6. Query the slide number and slide or note text.

    ````
    <copy>
    select SLIDE#, SLIDE_TEXT from V_SLIDES_TEXT where PPTX_NAME = '<presentation name>';
    select SLIDE#, NOTE_TEXT from V_NOTES_TEXT where PPTX_NAME = '<presentation name>';
    </copy>
    ````


## Task 5: Remove presentations from the repository

1. Use **Run Script** button or F5 to create a procedure that takes a presentation name as input parameter to remove it from the records.

    ````
    <copy>
    create or replace PROCEDURE PPTXJSON.REMOVE_PPTX (i_pptx_name IN VARCHAR2) AUTHID CURRENT_USER IS
      l_id VARCHAR2(255);
      d_collection SODA_COLLECTION_T;
      d_document SODA_DOCUMENT_T;
      d_status NUMBER default 0;
    BEGIN
      select d.ID into l_id from PPJSON d where d.JSON_DOCUMENT.pptx_name = i_pptx_name;
      dbms_output.put_line('PPT JSON id ' || l_id);
      FOR record IN (select PPT_JSON_ID, PPTX_NAME, JSON_ID, COLLECTION from V_PPJSON where PPT_JSON_ID = l_id)
      LOOP
        dbms_output.put_line('JSON id ' || record.JSON_ID || ' from collection ' || record.COLLECTION);
        d_collection := DBMS_SODA.open_collection(record.COLLECTION);
        d_status := d_collection.find().key(record.JSON_ID).remove;
      END LOOP;
      d_collection := DBMS_SODA.open_collection('PPJSON');
      d_status := d_collection.find().key(l_id).remove;
      delete from PPTX_DONE where PPTX_NAME = i_pptx_name;
      commit;
    END remove_pptx;
    /
    </copy>
    ````

2. Select processed presentation names from V_PPTX_DONE view.

    ````
    <copy>
    select PPTX_NAME from V_PPTX_DONE where PROCESSED is not NULL;
    </copy>
    ````

3. Execute the procedure that removes the presentation using the name from previous step as the input parameter.

    ````
    <copy>
    exec remove_pptx('<presentation name>');
    </copy>
    ````


## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, January 2023

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
