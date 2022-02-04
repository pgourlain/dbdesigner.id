# Change these four parameters as needed
$ACI_PERS_RESOURCE_GROUP="dbdesigner"
## uncomment to use file share and ACI
# $ACI_PERS_STORAGE_ACCOUNT_NAME="dbdesigner"
# $ACI_PERS_LOCATION="northeurope"
# $ACI_PERS_SHARE_NAME="acistorage"

# # Create the storage account with the parameters
# az storage account create --resource-group $ACI_PERS_RESOURCE_GROUP --name $ACI_PERS_STORAGE_ACCOUNT_NAME --location $ACI_PERS_LOCATION --sku Standard_LRS

# # Create the file share
# az storage share create --name $ACI_PERS_SHARE_NAME --account-name $ACI_PERS_STORAGE_ACCOUNT_NAME

# $STORAGE_KEY=$(az storage account keys list --resource-group $ACI_PERS_RESOURCE_GROUP --account-name $ACI_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)

# az container create --resource-group $ACI_PERS_RESOURCE_GROUP --name dbdesigner --image expaceo/dbdesigner --dns-name-label dbdesigner-demo --ports 80 --azure-file-volume-account-name $ACI_PERS_STORAGE_ACCOUNT_NAME --azure-file-volume-account-key $STORAGE_KEY --azure-file-volume-share-name $ACI_PERS_SHARE_NAME --azure-file-volume-mount-path /app/backend/storage/database

# create file if not exists, and fill it like this
# $DB_DATABASE=xxx
# $DB_HOST=yyy
# $DB_CLIENTID=<<your client id>>
# $DB_CLIENT_SECRET=<<your client secret>>
# $DB_TENANTID=<<your tenantid>>

. ./azure-setup-env.ps1

$yamlContent = Get-Content ./deploy-aci.yaml
$yamlContent=$yamlContent.Replace("#DB_DATABASE#", $DB_DATABASE)
$yamlContent=$yamlContent.Replace("#DB_HOST#", $DB_HOST)
$yamlContent=$yamlContent.Replace("#DB_CLIENTID#", $DB_CLIENTID)
$yamlContent=$yamlContent.Replace("#DB_CLIENT_SECRET#", $DB_CLIENT_SECRET)
$yamlContent=$yamlContent.Replace("#DB_TENANTID#", $DB_TENANTID)

Set-Content ./deploy-aci-filled.yaml -Value $yamlContent

az container create --resource-group $ACI_PERS_RESOURCE_GROUP --file .\deploy-aci-filled.yaml

az container show --resource-group "dbdesigner" --name dbdesigner --query ipAddress.fqdn --output tsv