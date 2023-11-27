#!/bin/bash

#Contributors: Adrian Humphrey, Nick Mann, Bryan Gavria, Walter Cardona

function copyDoc(){
    echo "Dumber"

    #HOW TO SEND IN AND RETURN A VARIABLE FOR PATH
    #function myfunc()
    #{
        #local  __resultvar=$1
        #local  myresult='some value'
        #eval $__resultvar="'$myresult'"
    #}

    #myfunc result
    #echo $result
}

function madLib(){
    pathVariable=$1
    echo "$pathVariable"

    copyDoc pathVariable

    #Take in input LINE BY LINE and alter/replace the blank sapces within each line of text. Look up how to take in a string Line by line and output it to the copied textfile.

}

function replaceAll(){
    #pathVariable=$1
    #echo "$pathVariable"
    echo "Balls"
}

function replaceFirst(){
    echo "Dummy"


}



user=$(whoami)

pathLink=$1

madLib "$pathLink"

sentinel=true
#This loop will let the user make edits to the madlib they just completed
#or it will allow them to start a new madlib, or quit.
while [ "$sentinel" = true ]
do
    echo "$user do you want to (R)eplace all, Replace (F)irst occurance, new (M)adLib, or (Q)uit."
    read -r userCommand
    #This is the equivalent of the switch statement that will take in and return the proper output file.
    if [ "$userCommand" = "R" ] || [ "$userCommand" = "r" ]
    then
        replaceAll
    elif [ "$userCommand" = "F" ] || [ "$userCommand" = "f" ]
    then
        replaceFirst
    elif [ "$userCommand" = "M" ] || [ "$userCommand" = "m" ]
    then
        madLib "$pathLink"
    elif [ "$userCommand" = "Q" ] || [ "$userCommand" = "q" ]
    then
        sentinel=false
    else
        echo "Please retry, $user, you entered invalid input."
    fi
    
done