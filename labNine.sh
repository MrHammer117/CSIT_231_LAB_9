#!/bin/bash

#Contributors: Adrian Humphrey, Nick Mann, Bryan Gaviria, Walter Cardona

#MAKE SURE TO RUN VIA THIS COMMAND, OTHERWISE IT WILL NOT RUN AS INTENDED:
#                               |||||
#                               VVVVV
#bash labNine.sh /home/hammer/Lab_Nine/CSIT_231_LAB_9/MadLib.txt

function copyDoc(){
    local source_file=$1
    local destination_directory="$PWD"

    local base_name="copy_file.txt"

    local destination_file="$destination_directory/$base_name"

    touch "$destination_file"
    cat "$source_file" > "$destination_file"

    echo "$destination_file"
}

function madLib(){
    local madFile=$1
    local wordToRplce="__________"
    
    # Count the exact occurrences of the placeholder word
    local line_count=$(awk -v word="$wordToRplce" '{ count += gsub(word, "") } END { print count }' "$madFile")
    

    for ((i = 1; i <= line_count; i++)); do
        echo "Please enter a word for the madlib:"
        read -r newWord
        replaceFirst "$wordToRplce" "$newWord" "$madFile"
    done
}

function replaceAll(){
    #pathVariable=$1
    #echo "$pathVariable"
    echo "Balls"
}

function replaceFirst() {
    local word_to_replace=$1
    local replacement_word=$2
    local cpFile=$3

    #This Replaces the first occurance of a particular word in a file                           This over here has the information print to a temp file 
#                             |                                                                 and then copy that back into the original copy_file.txt
#                             |                                                                                                     |
#                             V                                                                                                     V
#   ------------------------------------------------------------------------------------------------------------------  -------------------------
#   |                                                                                                                |  |                       |
    awk -v old="$word_to_replace" -v new="$replacement_word" '{if(!f && sub(old, new)) f=1} 1' "$cpFile" > tmpfile.txt && mv tmpfile.txt "$cpFile"
}

function main() {
    local user=$(whoami)
    local pathLink=$1

    local newFile=$(copyDoc "$pathLink")

    madLib "$newFile"

    local sentinel=true

    while [ "$sentinel" = true ]; do
        echo "$user, do you want to (R)eplace all, Replace (F)irst occurrence, new (M)adLib, or (Q)uit."
        read -r userCommand

        if [ "$userCommand" = "R" ] || [ "$userCommand" = "r" ]; then
            replaceAll
        elif [ "$userCommand" = "F" ] || [ "$userCommand" = "f" ]; then
            echo "Enter the word to replace:"
            read -r word_to_replace
            echo "Enter the replacement word:"
            read -r replacement_word
            replaceFirst "$word_to_replace" "$replacement_word" "$newFile"
            echo "Modified madlib: $(cat "$newFile")"
        elif [ "$userCommand" = "M" ] || [ "$userCommand" = "m" ]; then
            madLib "$newFile"
        elif [ "$userCommand" = "Q" ] || [ "$userCommand" = "q" ]; then
            sentinel=false
        else
            echo "Please retry, $user, you entered invalid input."
        fi
    done
}

# Call the main function with the provided argument
main "$1"