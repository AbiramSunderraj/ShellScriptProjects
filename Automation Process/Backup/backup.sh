#Started @ 08/09/2019 by Abiram Sundarraj
#set -x
clear
echo -e "************************Backup utility main menu (v 0.1)************************"

source ./function.sh #Path to the backup function's source file.


user=`whoami`             #Checking the username of the current tty user.

if [ "$user" = "root" ]   #run the script if it is root user, else exit.
then
str_loc  #Provide the function names below.
#dschk
else
echo -e "\n##Run this script as a root user.##\n"
fi
