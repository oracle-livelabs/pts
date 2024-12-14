# Update OCI CI/CD Pipeline with Front-End, Back-End, and Database Changes

## Introduction

In this lab, you will extend the functionality of your existing ToDo application by adding a new `priority` field to the tasks. This will involve:
- Updating the front-end UI to include the `priority` field.
- Modifying the Python back-end to handle the new field.
- Using Liquibase to apply the schema changes to the Oracle database.

This lab demonstrates how to implement end-to-end changes in a CI/CD environment managed on Oracle Cloud Infrastructure (OCI) with automated deployment to Oracle Kubernetes Engine (OKE).

Estimated time: 30 minutes

### Objectives

- Add a `priority` field to the ToDo application front-end.
- Modify the Python back-end to support the new `priority` field.
- Use Liquibase to automatically apply schema changes to the Oracle database.

---

## Task 1: Update the Front-End

### Step 1: Modify the Front-End Code to Add a New `Priority` Field

1. **Navigate to the front-end code** in your project folder `/templates`.

2. **Update the UI Component**:
   - Open the main UI file responsible for displaying ToDo items (file name: `index.html`).
   - Add a new column for displaying the `priority` field.

   update in the `index.html` (if using a table to display ToDo items):
   ```html
   <copy>   
    {% extends 'base.html' %}
    {% block content %}
    &lt;h1&gt;Todo List&lt;/h1&gt;
    &lt;div class="container"&gt;
        &lt;table class="table"&gt;
            &lt;thead&gt;
                &lt;tr&gt;
                    &lt;th&gt;ID&lt;/th&gt;
                    &lt;th&gt;Title&lt;/th&gt;
                    &lt;th&gt;Description&lt;/th&gt;
                    &lt;th&gt;Completed&lt;/th&gt;
                    &lt;th&gt;Priority&lt;/th&gt; &lt;!-- New Column for Priority --&gt;
                    &lt;th&gt;Due Date&lt;/th&gt;
                    &lt;th&gt;Actions&lt;/th&gt;
                &lt;/tr&gt;
            &lt;/thead&gt;
            &lt;tbody&gt;
                {% for todo in todos %}
                &lt;tr&gt;
                    &lt;td&gt;{{ todo[0] }}&lt;/td&gt;
                    &lt;td&gt;{{ todo[1] }}&lt;/td&gt;
                    &lt;td&gt;{{ todo[2] }}&lt;/td&gt;
                    &lt;td&gt;{{ 'Yes' if todo[3] == 'Y' else 'No' }}&lt;/td&gt;
                    &lt;td&gt
                        &lt;span class="{% if todo[6] == 3 %}text-danger{% elif todo[6] == 2 %}text-warning{% elif todo[6] == 1 %}text-success{% else %}text-muted{% endif %}"&gt;
                        {% if todo[6] == 3 %}
                            High
                        {% elif todo[6] == 2 %}
                            Medium
                        {% elif todo[6] == 1 %}
                            Low
                        {% else %}
                            N/A
                        {% endif %}
                        &lt;/span&gt;
                    &lt;/td&gt
                    &lt;td&gt;{{ todo[4] if todo[4] else 'N/A' }}&lt;/td&gt;
                    &lt;td&gt;
                        &lt;a href="{{ url_for('todo_detail', id=todo[0]) }}" class="btn btn-info"&gt;View&lt;/a&gt;
                        &lt;form action="{{ url_for('delete_todo', id=todo[0]) }}" method="post" style="display:inline;"&gt;
                            &lt;button type="submit" class="btn btn-danger"&gt;Delete&lt;/button&gt;
                        &lt;/form&gt;
                    &lt;/td&gt;
                &lt;/tr&gt;
                {% endfor %}
            &lt;/tbody&gt;
        &lt;/table&gt;
        &lt;a href="{{ url_for('create_todo') }}" class="btn btn-primary"&gt;Add New Todo&lt;/a&gt;
    &lt;/div&gt;
    {% endblock %}
    </copy>
    ```

3. **Add `priority` input in the ToDo creation form** (`todo_form.html`):
   ```html
   <copy>
    &lt;!doctype html&gt;
    &lt;html lang="en"&gt;
    &lt;head&gt;
        &lt;meta charset="utf-8"&gt;
        &lt;meta name="viewport" content="width=device-width, initial-scale=1"&gt;
        &lt;title&gt;Todo Form&lt;/title&gt;
        &lt;link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;div class="container"&gt;
            &lt;h1&gt;{% if todo %}Update{% else %}Create{% endif %} Todo&lt;/h1&gt;
            &lt;form method="post"&gt;
                &lt;div class="form-group"&gt;
                    &lt;label for="title"&gt;Title&lt;/label&gt;
                    &lt;input type="text" class="form-control" id="title" name="title" value="{{ todo[1] if todo else '' }}" required&gt;
                &lt;/div&gt;
                &lt;div class="form-group"&gt;
                    &lt;label for="description"&gt;Description&lt;/label&gt;
                    &lt;textarea class="form-control" id="description" name="description" required&gt;{{ todo[2] if todo else '' }}&lt;/textarea&gt;
                &lt;/div&gt;
                &lt;div class="form-group"&gt;
                    &lt;label for="completed"&gt;Completed&lt;/label&gt;
                    &lt;select class="form-control" id="completed" name="completed"&gt;
                        &lt;option value="Y" {% if todo and todo[3] == 'Y' %}selected{% endif %}&gt;Yes&lt;/option&gt;
                        &lt;option value="N" {% if todo and todo[3] == 'N' %}selected{% endif %}&gt;No&lt;/option&gt;
                    &lt;/select&gt;
                &lt;/div&gt;
                &lt;div class="form-group"&gt;
                    &lt;label for="due_date"&gt;Due Date&lt;/label&gt;
                    &lt;input type="date" class="form-control" id="due_date" name="due_date" value="{{ todo[4].strftime('%Y-%m-%d') if todo and todo[4] else '' }}"&gt;
                &lt;/div&gt;
                &lt;div class="form-group"&gt;
                    &lt;label for="priority"&gt;Priority&lt;/label&gt;
                    &lt;select class="form-control" id="priority" name="priority"&gt;
                        &lt;option value="Low">Low</option&gt;
                        &lt;option value="Medium">Medium</option&gt;
                        &lt;option value="High">High</option&gt;
                    &lt;/select&gt;
                &lt;/div&gt;
                &lt;button type="submit" class="btn btn-primary"&gt;Submit&lt;/button&gt;
            &lt;/form&gt;
            &lt;a href="{{ url_for('index') }}" class="btn btn-secondary"&gt;Back to List&lt;/a&gt;
        &lt;/div&gt;
    &lt;/body&gt;
    &lt;/html&gt;
    </copy>
    ```

4. **Push the Front-End Changes** to the OCI DevOps repository:
   ```bash
   git add .
   git commit -m "Add Priority field to front-end"
   git push
   ```

---

---

## Task 2: Update the Back-End

### Step 1: Modify the Back-End Code to Add the `Priority` Field

To support the new `priority` field in the application, update the Flask back-end (`app.py`) to include this field in the database queries and routes.

#### Changes Required:
1. Update SQL queries to handle the `priority` field.
2. Modify the `create_todo` and `update_todo` routes to accept and save the `priority` field.
3. Sort the tasks by `priority` in the `index` route for consistent UI behavior.

---

#### Updated `app.py` with Priority Field Support

Here’s the updated `app.py` with the necessary changes to handle the `priority` field:

```python
<copy>
from flask import Flask, render_template, request, redirect, url_for
import cx_Oracle
import configparser
import os
from datetime import datetime

app = Flask(__name__)

# Read configuration from config.cfg
config = configparser.ConfigParser()
config.read('config.cfg')

# Oracle database configuration
username = config['database']['USER']
password = config['database']['PASSWORD']
dsn = config['database']['TNS_SERVICE_NAME']
wallet_path = config['database']['TNS_ADMIN']

# Set the TNS_ADMIN environment variable to the wallet directory path
os.environ['TNS_ADMIN'] = wallet_path

def get_db_connection():
    try:
        connection = cx_Oracle.connect(user=username, password=password, dsn=dsn)
        return connection
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Error connecting to the database: {error.message}")
        exit(1)

@app.route('/')
def index():
    """Display all tasks sorted by priority."""
    base_url = request.base_url
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM todos ORDER BY priority ASC")  # Sort by priority
    todos = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('index.html', todos=todos, base_url=base_url)

@app.route('/todo/<int:id>', methods=['GET'])
def todo_detail(id):
    """Display the details of a specific todo."""
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM todos WHERE id = :id", [id])
    todo = cursor.fetchone()
    cursor.close()
    connection.close()
    
    if todo:
        return render_template('todo_detail.html', todo=todo)
    return "Todo not found", 404

@app.route('/todo/delete/<int:id>', methods=['POST'])
def delete_todo(id):
    """Delete a specific todo."""
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute("DELETE FROM todos WHERE id = :id", [id])
    connection.commit()
    cursor.close()
    connection.close()
    return redirect(url_for('index'))


@app.route('/todo/new', methods=['GET', 'POST'])
def create_todo():
    """Create a new task with priority."""
    base_url = request.base_url
    if request.method == 'POST':
        title = request.form['title']
        description = request.form['description']
        completed = request.form.get('completed', 'N')
        due_date_str = request.form.get('due_date')  # New field
        priority_mapping = {
        'Low': 1,
        'Medium': 2,
        'High': 3
        }

        priority = request.form.get('priority', 'Low')  # Default to 'Low' if not provided
        priority_value = priority_mapping.get(priority, 0)  # Default to 0 if invalid


        # Parse date string to datetime object
        due_date = None
        if due_date_str:
            try:
                due_date = datetime.strptime(due_date_str, '%Y-%m-%d')
            except ValueError:
                return "Invalid date format. Use YYYY-MM-DD.", 400

        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("""
            INSERT INTO todos (title, description, completed, due_date, priority)
            VALUES (:title, :description, :completed, :due_date, :priority)
        """, [title, description, completed, due_date, priority_value])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('index'))

    return render_template('todo_form.html', base_url=base_url)

@app.route('/todo/<int:id>/edit', methods=['GET', 'POST'])
def update_todo(id):
    """Update an existing task including its priority."""
    base_url = request.base_url
    connection = get_db_connection()
    cursor = connection.cursor()
    if request.method == 'POST':
        title = request.form['title']
        description = request.form['description']
        completed = request.form.get('completed', 'N')
        due_date_str = request.form.get('due_date')  # New field
        priority = request.form.get('priority', 0)  # New priority field (default 0)

        # Parse date string to datetime object
        due_date = None
        if due_date_str:
            try:
                due_date = datetime.strptime(due_date_str, '%Y-%m-%d')
            except ValueError:
                return "Invalid date format. Use YYYY-MM-DD.", 400

        cursor.execute("""
            UPDATE todos
            SET title = :title,
                description = :description,
                completed = :completed,
                due_date = :due_date,
                priority = :priority
            WHERE id = :id
        """, [title, description, completed, due_date, int(priority), id])
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('index'))

    cursor.execute("SELECT * FROM todos WHERE id = :id", [id])
    todo = cursor.fetchone()
    cursor.close()
    connection.close()
    if todo:
        return render_template('todo_form.html', todo=todo, base_url=base_url)
    return "Todo not found", 404

@app.route('/dashboard')
def dashboard():
    """Display statistics and recent tasks on the dashboard."""
    base_url = request.base_url
    connection = get_db_connection()
    cursor = connection.cursor()

    # Get total count of todos
    cursor.execute("SELECT COUNT(*) FROM todos")
    total_todos = cursor.fetchone()[0]

    # Get count of completed todos
    cursor.execute("SELECT COUNT(*) FROM todos WHERE completed = 'Y'")
    completed_todos = cursor.fetchone()[0]

    # Get count of incomplete todos
    cursor.execute("SELECT COUNT(*) FROM todos WHERE completed = 'N'")
    incomplete_todos = cursor.fetchone()[0]

    # Get recent todos sorted by priority
    cursor.execute("SELECT * FROM todos ORDER BY priority ASC FETCH FIRST 5 ROWS ONLY")
    recent_todos = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template('dashboard.html', 
                           base_url=base_url, 
                           total_todos=total_todos,
                           completed_todos=completed_todos,
                           incomplete_todos=incomplete_todos,
                           recent_todos=recent_todos)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
</copy>
```

Highlights

  - Priority Sorting: Added ORDER BY priority ASC to sort tasks in queries.
  - Priority Field in Form: Extracted priority from the form in create\_todo and update\_todo.
  - SQL Changes: Updated INSERT and UPDATE queries to include the priority field.

These changes ensure that tasks are now prioritized and visible according to their priority value.


---

### Step 2: Push the Back-End Changes to the Repository

1. **Commit and push the changes**:
   ```bash
   git add app.py
   git commit -m "Add priority field to back-end routes and database queries"
   git push
   ```

This completes the back-end changes required to support the `priority` field in the ToDo application.

---

## Task 3: Update the Database with Liquibase

### Step 1: Create a New Liquibase Changelog for Schema Changes

1. **Create a new changelog file** in the Liquibase changelog directory (e.g., `/liquibase/changelog/add_priority_field.xml`).

2. **Define the new `priority` column** in the changelog XML:
   ```html
   <copy>
    &lt;databaseChangeLog
    xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.8.xsd"&gt
        &lt;changeSet id="3" author="devops"&gt;
            &lt;addColumn tableName="todos"&gt;
                &lt;column name="priority" type="INT"&gt;
                    &lt;constraints nullable="true"/&gt;
                &lt;/column&gt;
            &lt;/addColumn&gt;
        &lt;/changeSet&gt;
    &lt;/databaseChangeLog&gt    
   ```



3. **Update the master changelog** (`master-changelog.xml`) to include the new changelog file:
   ```html
   <copy>
   &lt;include file="/liquibase/changelog/add_priority_field.xml"/&gt;
   ```

### Step 2: Commit and Push the Liquibase Changes

1. **Add, commit, and push the Liquibase changes** to the OCI DevOps repository:
   ```bash
   git add .
   git commit -m "Add priority column to todos table"
   git push
   ```

---

## Task 4: Update Application Version

1. Update the app version in the **build\_spec.yaml** file in root folder (variable name: BUILDRUN_HASH ).
2. change it from 0.0.1 to 0.0.2
    ```bash
    env:
        variables:
            BUILDRUN_HASH: "0.0.2"    
    ```

---
## Task 5: Deploy and Test the Changes

### Step 1: Trigger the Build and Deploy Pipeline

1. **Go to the Build Pipeline** and trigger a build manually.
2. **Monitor the pipeline** to ensure that each stage (front-end, back-end, database) completes successfully.

### Step 2: Access the Application and Verify

1. **Access the Application URL** (e.g., via Load Balancer IP).
2. **Verify the New `Priority` Column**:
   - Check that the `Priority` column appears on the front-end of the ToDo app.
   - Create a new ToDo item with a `priority` value, and verify that it is stored correctly in the database.

---

## Conclusion

In this lab, you’ve successfully added a `priority` field to your To-Do app across the full stack (front-end, back-end, and database). This change was integrated into your OCI CI/CD pipeline, demonstrating how to automate schema updates and deployment to Oracle Kubernetes Engine (OKE). This workflow ensures that your app can evolve rapidly while maintaining consistency and automation throughout the pipeline.