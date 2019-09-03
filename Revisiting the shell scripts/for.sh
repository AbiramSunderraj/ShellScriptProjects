echo "Enter a path of the directory"   #Asking user to enter the path of a directory to which the files & folders name to display
read path
for i in $path/*              #Looping through the certain directory path
do
     if [ -d $i ]             #select only the directories and display their name
     then
        echo "$i"
     fi
done

##For loop is useful for looping into the directories
