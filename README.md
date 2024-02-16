# Vending Machine Rental Database
A company renting out vending machines to different locations.

## Information of technologies and methods

there are 3 scripts to set up the database located in ./sql/main/, and their purpose is as follows:
- create_db = create the database VendingMachineRentalDB and switch to it
- create_table_keys = create the relevant tables defined in the ERD along with their primary and foreign key.
- add_constraints = add the relevant constraints to the db.
These scripts were run manually in SQL Server Management Studio to the database engine 
other sql scripts were used to either fix the mistakes during development or test Liquibase migrations. 

Liquibase takes a specified sql script and pushes it to the database on the aws instance via github action's CI/CD.
The sql script is manually configured in the yaml file. The path of the script can technically be anywhere in the repo, but is recommend to be in ./sql/

## Starting from scratch
1. Create an AWS RDS instance, either through the management console or Terraform
2. Connect SQL Server Management Studio to this instance and run the main/ SQL scripts.
3. Populate the tables with some data.
4. Basic DB created!
5. Run the function/ SQL scripts in SQL Server Management Studio to apply relevant views, procs, and UDFs.
### Prerequisite:
* Running aws configure in terminal to setup ur profile's sso
* See for more details: https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html#sso-configure-profile-token-auto-sso
* sql

## ./sql/main
create_db.sql -> Creates the db and uses it

create_table_keys.sql -> uses the db and creates the table, PKs, and FKs on latest agreed ERD.

add_constraints.sql -> Tables' constraints for their relevant column and input.
