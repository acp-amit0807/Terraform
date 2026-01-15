## Installing Terraform
    choco terraform -y

## Extension to install
    HashiCorp Terraform

    Format On Save --> true

## Azure CLI
    choco install azure-cli -y

## Terraform commands
 1. terraform init
 2. terraform plan
 3. terraform apply
 4. terraform destroy

terraform init -upgrade

 ----------------------------------------------
   STEP         CODE              STATE       ENV 
    1.        Random String
    2.        PLAN                ?
    3.        APPLY               SOM9b[       SOM9b[ 
    4.        upper = false

 ----------------------------------------------

a.  terraform plan -var "application_name=blog"
b.  terraform apply -var-file "dev.tfvars"
c.  terraform output application_name

Local Variables
Global / members variables

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

 terraform apply -var-file .\env\dev.tfvars