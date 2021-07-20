#New line

# devops-netology
new line
Second line
Third line

#The directory terraform has the file .getignore which will be used to ignore files located in terraform directory

**/.terraform/* 
#Игнорируются все файлы в директории до каталога .terraform и любые файлы внутри каталога .terraform

*.tfstate
*.tfstate.*
#Игорируются файлы с расширением .tfstate, а также файлы вида хх.tfstate.xx

crash.log
#Ignore crash.log file

*.tfvars
#Ignore files with extension tfvars


#Ignore files override.tf, override.tf.json and with the names XXX_override.tf, XXX_override.tf.json
override.tf
override.tf.json
*_override.tf
*_override.tf.json


#Ignore files .terraformrc and terrafrom.rc
.terraformrc
terraform.rc


# 
