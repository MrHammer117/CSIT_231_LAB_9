#!/bin/bash

#Contributors: Adrian Humphrey, Nick Mann, Bryan Gavria, Walter Cardona

function copyDoc(){
    originalPath=$1
    newPath=2
    cat "$originalPath"> new_document.txt
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

    #echo "It was __________, cold November day. [Adjective]: "
    #read ans
    
    #echo "I woke up to the _________ smell of ___________ roasting in the __________ downstairs. [Adjective/Type of bird/Room in a house]: "
    #read ans2 ans3 ans4

    #echo "I ___________ down the stairs to see if I could help ________ the dinner. [Verb, past tense/Verb]: "
    #read ans5 ans6

    #echo "My mom said, "See if _________ needs a fresh ______." So I carried a tray of glasses full of _________ into the ____________ room. [Name/Noun/A liquid/Verb ending in -ing]: "
    #read ans7 ans8 ans9 ans10

    #echo "When I got there, I couldn't believe my _________! There were __________    ________ on the __________! [Part of the body, plural/Plural noun/Verb ending in -ing/Noun]"
    #read ans11 ans12 ans13 ans14


    #echo "Your mad lib here: "
    #echo "It was $ans, cold November day."
    #echo "I woke up to the $ans2 smell of $ans3 roasting in the $ans4 downstairs."
    #echo "I $ans5 down the stairs to see if I could help $ans6 the dinner."
    #echo "My mom said, "See if $ans7 needs a fresh $ans8." So I carried a tray of glasses full of $ans9 into the $ans10 room."
    #echo "When I got there, I couldn't believe my $ans11! There were $ans12 $ans13 on the $ans14!"
}

function replaceAll(){
    #pathVariable=$1
    #echo "$pathVariable"
    echo "Balls"
}

#!/bin/bash

function replaceFirst() {
    local madlib_template=$1
    local word_to_replace=$2
    local replacement_word=$3

    # Find the first occurrence of the word and replace it
    local modified_madlib=$(echo "$madlib_template" | sed "s/\b$word_to_replace\b/$replacement_word/")

    echo "$modified_madlib"
}

function main() {
    local user=$(whoami)
    local pathLink=$1

    madLib "$pathLink"
    local original_madlib="$madlib"  # Save the original madlib

    local sentinel=true

    while [ "$sentinel" = true ]; do
        echo "$user do you want to (R)eplace all, Replace (F)irst occurrence, new (M)adLib, or (Q)uit."
        read -r userCommand

        if [ "$userCommand" = "R" ] || [ "$userCommand" = "r" ]; then
            replaceAll
        elif [ "$userCommand" = "F" ] || [ "$userCommand" = "f" ]; then
            echo "Enter the word to replace:"
            read -r word_to_replace
            echo "Enter the replacement word:"
            read -r replacement_word
            original_madlib=$(replaceFirst "$original_madlib" "$word_to_replace" "$replacement_word")
            echo "Modified madlib: $original_madlib"
        elif [ "$userCommand" = "M" ] || [ "$userCommand" = "m" ]; then
            madLib "$pathLink"
            original_madlib="$madlib"  # Save the new madlib
        elif [ "$userCommand" = "Q" ] || [ "$userCommand" = "q" ]; then
            sentinel=false
        else
            echo "Please retry, $user, you entered invalid input."
        fi
    done
}

# Call the main function with the provided argument
main "$1"
