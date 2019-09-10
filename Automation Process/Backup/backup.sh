#Backup automation - 08/09/2019
#set -x
echo -e "\n*************** BACKUP PROCESS ****************"
echo -e "*FOR BETTER EXPIRENCE RUN WITH ROOT PRIVILAGES*" #Next implementation: run if the user is root or exit

source ./function.sh

type_select
location_select
