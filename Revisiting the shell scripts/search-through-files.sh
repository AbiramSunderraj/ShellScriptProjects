echo "Enter a input string"
read str                 # Asks the string from user
echo "Do you know the exact file and path of the string? [Y/N]"       # Asks user whether they knows which file to search
read ans                 # reading the answer

if [ "$ans" = "Y" -o "$ans" = "y" ]                    #if YES asks the user to enter file name with path and search
then
     echo "Enter the filename with path"
     read fname
     grep $str -i "$fname"
elif [ "$ans" = "N" -o "$ans" = "n" ]                  #if NO script will search through the entire directory
then
     echo "Wait sometime while the search completes."
     grep $str -ilr /
else                                                   #Script will end if any wrong input is provided
     echo "INVALID INPUT"
     echo "Exiting the script . . ."
     sleep 2
     exit
fi
