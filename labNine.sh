#!/bin/bash

#Contributors: Adrian Humphrey, Nick Mann, Bryan Gavria, Walter Cardona
function madLib(){
    pathVariable=$1
    echo "$pathVariable"

    echo "Hello"










}

function replaceAll(){
    #pathVariable=$1
    #echo "$pathVariable"
    echo "Balls"
}

function replaceFirst(){
    echo "Dummy"
}

function copyDoc(){
    echo "Dumber"
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