user = $(whoami)

function madLib(){

}

function replaceAll(){

}

function replaceFirst(){

}

madLib

sentinel = true
#This loop will let the user make edits to the madlib they just completed
#or it will allow them to start a new madlib, or quit.
while[$sentinel = true]
do
    echo "$user do you want to (R)eplace all, Replace (F)irst occurance, new (M)adLib, or -Q quit."
    read userCommand
    #This is the equivalent of the switch statement that will take in and return the proper output file.
    if[$userCommand = "R"]
    then
        replaceAll
    fi
    if[$userCommand = "F"]
    then
        replaceFirst
    fi
    if[$userCommand = "M"]
    then
        madLib
    fi
    if[$userCommand = "Q"]
    then
        sentinel = false
    fi

done