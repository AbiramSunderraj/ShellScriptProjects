echo "Enter minimum value"   #Asks the user to provide min value and store it
read min_val
echo "Enter maximum value"   #Asks the user to provide max value and store it
read max_val
until [ $min_val -ge $max_val ]   #Checking the condition
do
     echo "$min_val"          #displays the current minimum value
     min_val=`expr $min_val + 1`  #incrementing the minimum value by 1
done
