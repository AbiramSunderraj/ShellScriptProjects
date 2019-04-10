echo "ENTER A NUMBER: \c"
read num
until [ $num -le 10 ]
do
echo "$num"
num=`expr $num - 1`
done
