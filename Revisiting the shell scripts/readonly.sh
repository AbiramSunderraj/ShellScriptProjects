#Readonly keyword applies for Variables and Functions

#readonly variable=values

readonly val=16    #Assigning value for readonly variable "var"
echo "Val is $val, before changing the value." #Displaying output.

val=25             #Trying to change the value for variable "var"
echo "Val is $val, after changing the value." #Displaying output again.


#readonly -f function_name

fun1(){         #Declaring a function and getting an argument
	local var=$name
	echo "Hello $var"
}

echo -e "Enter a name: \c"
read name           #Providing arg to fun1
fun1 $name          #Calling fun1 with arg

readonly -f fun1    #making fun readonly

fun1(){    #Trying to change the value inside a function fun1
	local var="Abiram"
	echo "Hello $var"
}

fun1    #Calling fun1 again



# OUTPUT
# Val is 16, before changing the value.
# ./readonly.sh: line 8: val: readonly variable
# Val is 16, after changing the value.
# Enter a name:Root
# Hello Root
# ./readonly.sh: line 28: fun1: readonly function
# Hello Root
