# Azure PAAS Database configuration 

### Seleceted Database  - Postgres
### Selected Technology - Terraform

## Getting started -
https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portalhttps://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal

- Server name	mydemoserver	- A unique name that identifies your Azure Database for PostgreSQL server. The domain name postgres.database.azure.com is appended to the server name you provide. The server can contain only lowercase letters, numbers, and the hyphen (-) character. It must contain at least 3 through 63 characters.

- Data source	None	Select None to create a new server from scratch. (You would select Backup if you were creating a server from a geo-backup of an existing Azure Database for PostgreSQL server).

- Admin username	myadmin	Your own login account to use when you connect to the server. The admin login name can't be azure_superuser, azure_pg_admin, admin, administrator, root, guest, or public. It can't start with pg_.


- Compute + storage	General Purpose, Gen 5, 2 vCores, 5 GB, 7 days, Geographically Redundant	The compute, storage, and backup configurations for your new server. Select Configure server. Next, select the General Purpose tab. Gen 5, 4 vCores, 100 GB, and 7 days are the default values for Compute Generation, vCore, Storage, and Backup Retention Period. You can leave those sliders as is or adjust them. To enable your server backups in geo-redundant storage select Geographically Redundant from the Backup Redundancy Options. To save this pricing tier selection, select OK. The next screenshot captures these selections.


# Details
- By default, a postgres database is created under your server. The postgres database is a default database that's meant for use by users, utilities, and third-party applications. (The other default database is azure_maintenance.

- Configure a server-level firewall rule
Azure Database for PostgreSQL creates a firewall at the server level. It prevents external applications and tools from connecting to the server and any databases on the server, unless you create a rule to open the firewall for specific IP addresses.

- Connections to your Azure Database for PostgreSQL server communicate over port 5432. When you try to connect from within a corporate network, outbound traffic over port 5432 might not be allowed by your network's firewall. If so, you can't connect to your server unless your IT department opens port 5432.

# Connection

Run the following psql command to connect to an Azure Database for PostgreSQL server

Bash

Copy
psql --host=<servername> --port=<port> --username=<user@servername> --dbname=<dbname>
For example, the following command connects to the default database called postgres on your PostgreSQL server mydemoserver.postgres.database.azure.com using access credentials. Enter the <server_admin_password> you chose when prompted for password.

Bash

Copy
psql --host=mydemoserver.postgres.database.azure.com --port=5432 --username=myadmin@mydemoserver --dbname=postgres





# Using CLI
https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-azure-cli

az postgres server create --resource-group myresourcegroup --name mydemoserver  --location westus --admin-user myadmin --admin-password <server_admin_password> --sku-name GP_Gen4_2 --version 9.6


The sku-name parameter value follows the convention {pricing tier}_{compute generation}_{vCores} as in the examples below:

--sku-name B_Gen5_1 maps to Basic, Gen 5, and 1 vCore. This option is the smallest SKU available.
--sku-name GP_Gen5_32 maps to General Purpose, Gen 5, and 32 vCores.
--sku-name MO_Gen5_2 maps to Memory Optimized, Gen 5, and 2 vCores.


- Configure a server-level firewall rule
aniket@Azure:~$ az postgres server firewall-rule create --resource-group test-db-rg --server test-db-svr --name postgres-test-db-svc --start-ip-address 10.161.72.5 --end-ip-address 10.161.72.5

ERROR- Requested feature is not enabled



- Get the connection information
To connect to your server, you need to provide host information and access credentials.
az postgres server show --resource-group myresourcegroup --name mydemoserver



# RUN the terraform code
# #############################################################



terraform init
terraform plan

### give couple of errors -
  1. data block has to be in the same file where you are refferencing it otherwise it will throw error
  2. set environment variable does not work in windows while authenticating with Azure platform
      - Created credential.auto.tfvars
      - set tenant and subscription details in main.tf in azurerm block

s

## Got another error 
Error: postgresql.FirewallRulesClient#CreateOrUpdate: Failure sending request: StatusCode=405 -- Original Error: Code="FeatureSwitchNotEnabled" Message="Requested feature is not enabled"

Change collation to -  collation           = "English_United States.1252"


### Got another error while defining firewall rule

Error: postgresql.FirewallRulesClient#CreateOrUpdate: Failure sending request: StatusCode=405 -- Original Error: Code="FeatureSwitchNotEnabled" Message="Requested feature is not enabled"

  on azure_database.tf line 52, in resource "azurerm_postgresql_firewall_rule" "postgres-test-db-svc":
  52: resource "azurerm_postgresql_firewall_rule" "postgres-test-db-svc" {

- From frontend also I am unable to create firewall rule -
  Allow access to Azure services
  it is disabled
  test-db-svr | Connection security


## Verification -
az postgres db list -g test-db-rg -s test-db-svr
-  it creates 4 databases -
  azure_sys
  azure_maintenance
  postgres
  testdb

az postgres db show -g test-db-rg -s test-db-svr -n testdb

# delete lock is enabled for this database server

## Connect to database
psql "host=test-db-svr.postgres.database.azure.com port=5432 dbname=testdb user=testadmin@test-db-svr  sslmode=require"

=> above command works from server 

- have to test that
psql -v sslmode=true --host="test-db-svr.postgres.database.azure.com" --port=5432 --username=testadmin@test-db-svr  --dbname=testdb --password

nodejs
host=test-db-svr.postgres.database.azure.com port=5432 dbname={your_database} user=testadmin@test-db-svr password={your_password} sslmode=require

python
dbname='{your_database}' user='testadmin@test-db-svr' host='test-db-svr.postgres.database.azure.com' password='{your_password}' port='5432' sslmode='true'

