echo "Type new and old file names, seperated by space respectivly."
read old new
if `mv $old $new`
then 
	echo "Files have been moved successfuly."
fi
