echo "Enter the extension of the file: \c"
read ft
echo "Enter a name to be prepend: \c"
read fn
a=0
for i in *.$ft
do
	a=`expr $a + 1`		#Appending a series of number before prepending text
	mv -v $i $fn$a.$ft	#Renaming the file, -v is used to view the ongoing process of rename.
done
