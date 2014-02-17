# git-sql

A git extension to allow version-controlling SQL databases independent of ORMs and special entity-relational management libraries.

[![Build Status](https://travis-ci.org/proegssilb/git-sql.png?branch=master)](https://travis-ci.org/proegssilb/git-sql)

## Background/Theory of Operation

The extension will work by translating the current database state into scripts, and version controlling those scripts. There are two things that make this possible:

- Diffs can detect line edits, not just removals/additions
- You cannot rearrange columns in a database.

Because you cannot rearrange columns in a database, rearranging columns in a table creation script is nonsensical. Therefore, any attempts to rename columns or change the data type on them is merely a line edit in the diffs. New text and deleted text can be assumed to be new/deleted columns.

Views, indexes, sprocs, and functions do not need such careful handling; it is the fact that editing a table creates side-effects in its data that requires careful management of table changes. Similarly, if a table's data is version-controlled, there is no need to micromanage edits.

## Requirements

A "checklist" of features to implement. Plain-text is not done yet, some formatting scheme yet to be selected indicates completed requirements.

This will eventually be moved when the list becomes unwieldy for the readme.

### General

- Record changes to .database/ in repository root
- Allow user to specifically add tables to staging
- Allow user to manually sync via command
- On checkout/pull/update/merge/..., write changes from .database/ to DB
- On status check, sync DB -> .database/

### Databases

- Provide command to add DB to version control and create DB on server
- Allow for custom create on databases
- Allow for custom delete on databases
- Provide command to rename a DB via custom create/delete

### Table Management

- Allow for custom create in tables, columns
- Allow for custom delete in tables, columns
- Detect new tables, generate basic table creation script
- Must detect new columns in existing tables
- If new columns, must add them to existing table scripts
- Must detect type/name changes to existing columns based on column ordinal, and update table scripts.
- Provide command to rename columns/tables via custom delete/create
- Detect changes to Primary Key, creating appropriate SQL script, including sane name generation
- Detect changes to Constraints, creating appropriate SQL script, including sane name generation
- Detect changes to indexes, create/updates SQL script, including sane name generation
- Detect table deletions
- Provide command to track data changes in tables
- Sync changes to data in data-tracked tables

### View Management

- When a view changes, regenerate script.
- Detect new views
- Detect view deletions

### Sproc, Function management

- When a sproc/func changes, regenerate script.
- Detect new sprocs/funcs
- Detect sproc/func deletion
