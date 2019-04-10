echo "Enter file name to be processed: \c"
read fname

if [ -z $fname ]
then
	exit
fi
for i in `cat $fname`
do
	cwd=`pwd`
	man $i > $cwd/$i
done
	
