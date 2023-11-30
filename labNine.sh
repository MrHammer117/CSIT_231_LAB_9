#!/bin/bash

#Contributors: Adrian Humphrey, Nick Mann, Bryan Gaviria, Walter Cardona

#MAKE SURE TO RUN VIA THIS COMMAND, OTHERWISE IT WILL NOT RUN AS INTENDED:
#                               |||||
#                               VVVVV
#bash labNine.sh /home/hammer/Lab_Nine/CSIT_231_LAB_9/MadLib.txt

#This function makes a new file called Copy_file, which is the file that has the madlib stored to edit.

function copyDoc(){
    #This function creates a copy of the original
    local source_file=$1
    local destination_directory="$PWD"

    local base_name="copy_file.txt"

    #Makes the destination file path by putting together the destination directory and base name
    local destination_file="$destination_directory/$base_name"

    #Creates an empty file at the destination path
    touch "$destination_file"

    #Copies the source files contnets and puts it in destination file
    cat "$source_file" > "$destination_file"

    #This will output the path of the destination file
    echo "$destination_file"
}

function madLib(){
    local madFile=$1
    local wordToRplce="__________"
    
    # Count the exact occurrences of the placeholder word
    local line_count=$(awk -v word="$wordToRplce" '{ count += gsub(word, "") } END { print count }' "$madFile")

    
    cat "$madFile"
    echo ""
    echo ""
    echo ""
    #the for loop will print out the madlib and will ask the user for input.
    #After every input, the madlib will update the current line with what the user typed in. 
    #This loop also edits the madlib text document.
    for ((i = 1; i <= line_count; i++)); do
        echo "Please enter a word for the madlib:"
        read -r newWord
        replaceFirst "$wordToRplce" "$newWord" "$madFile"
        cat "$madFile"
        echo ""
        echo ""
    done
    echo ""
    echo ""
    echo ""
    echo "Done with the MadLib:"
    echo ""
    echo ""
    cat "$madFile"
}

function replaceAll(){
    #Just the set of local variables, each $(number) is the order in which they will be called.
    local word_to_replace=$1
    local replacement_word=$2
    local cpFile=$3

    # Replace all occurrences of a particular word in a file
    #This line of code starts with awk which is used to read from the copy file and creates a temp file which then overrites the copyfile.
    awk -v old="$word_to_replace" -v new="$replacement_word" '{ gsub(old, new) } 1' "$cpFile" > tmpfile.txt && mv tmpfile.txt "$cpFile"
    
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
#                                                            |                                |
#                                                            ----------------------------------
#                                                                           ^
#                                                                           |
#                                                           This is what substitutes the old word 
#                                                           out with the new word! f=1 determines
#                                                           that we are only changing the first 
#                                                           word!
}

function main() {
    #This function essential holds the menu which you can select optons from.

     
    local user=$(whoami)
    local pathLink=$1

    local newFile=$(copyDoc "$pathLink")

    madLib "$newFile"

    local sentinel=true
#This is the main menu loop that will only exit upon entering (q) other wise we have 3 function to choose from.
    while [ "$sentinel" = true ]; do
        echo "$user, do you want to (R)eplace all, Replace (F)irst occurrence, new (M)adLib, or (Q)uit."
        read -r userCommand

        #If (R) is entered after the creation of your madLib you can replace all of the instances of a word you used.
        if [ "$userCommand" = "R" ] || [ "$userCommand" = "r" ]; then
            echo "Enter the word to replace:"
            read -r word_to_replace
            echo "Enter the replacement word:"
            read -r replacement_word
            replaceAll "$word_to_replace" "$replacement_word" "$newFile"
            echo "Modified madlib: $(cat "$newFile")"
        #Entering (F) will allow you to replace the first line of the madlib
        elif [ "$userCommand" = "F" ] || [ "$userCommand" = "f" ]; then
            echo "Enter the word to replace:"
            read -r word_to_replace
            echo "Enter the replacement word:"
            read -r replacement_word
            replaceFirst "$word_to_replace" "$replacement_word" "$newFile"
            echo "Modified madlib: $(cat "$newFile")"
        #Allows you to create a new madlib upon entering (M).
        elif [ "$userCommand" = "M" ] || [ "$userCommand" = "m" ]; then
            local copyFile=$(copyDoc "$pathLink")
            madLib "$copyFile"
        #Entering (q) will quit out the program.
        elif [ "$userCommand" = "Q" ] || [ "$userCommand" = "q" ]; then
            sentinel=false
        #This else statement is for input validation to check if you entered one of the above options.
        else
            echo "Please retry, $user, you entered invalid input."
        fi
    done
}

# Call the main function with the provided argument
main "$1"