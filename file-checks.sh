echo "enter a file or directory name."
read name
if [ -f $name ]
then
	echo "THIS IS A FILE NAME."
elif [ -d $name ]
then
	echo "THIS IS A DIRECTORY NAME."
else
	echo "THIS IS NOR A FILE NEITHER A DIRECTORY NAME."
fi
