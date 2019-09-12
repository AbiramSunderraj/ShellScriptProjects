#function declaration#

# function name(){
#       commands
# }

function print(){ #function declaration, does not need that "function" keyword anyway.
        echo "Hello World"
}

print #calling the function


args(){ #function declaration without "function" keyword and getting arguments
	echo $1 $2
}

args arg1 arg2 #calling "arg" function and passing the arguments 'arg1', 'arg2'

country="Netherlands"  #Just assigning a value for a variable
echo "$country"
local_call(){          #Used to locally called a variable
	local country="India"  #Using the keyword "local" so, the value will exist inside of this function only
	echo "$country"
}

local_call       #accessing the local_call function to print the value it have
echo "$country"  #echoing the country variable again to know what value it holds
