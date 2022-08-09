
#!/bin/bash

target_directory=$1


if [ ! -d "$target_directory" ]; #checks if the new directory already exists, if not it creates a new one
then
	mkdir "$target_directory"
fi


for file in /cs/studres/CS1007/Assessment/Reassessment/sourcedata/descriptions/* #iterate thorugh every file in descriptions sub-directory
do
	title=$(head -n 1 $file | gawk 'BEGIN{FS=": "} {print $2}') #breaks first line of file with the delimiter : , and takes the 2nd value ( as first line in form of Title: name_of_tree)
	mkdir "$target_directory/$title" #makes a new sub-directory inside target directory using the description title as a name

	file_title=$(echo "$file" | gawk 'BEGIN{FS="[/.]"} {print $8}') #splits file path using / and . as delimeters (. to also split the file extension) and taking the 8th element
	cp "/cs/studres/CS1007/Assessment/Reassessment/sourcedata/images/$file_title.jpg" "/cs/studres/CS1007/Assessment/Reassessment/sourcedata/images/$file_title-copyright.txt" "$target_directory/$title" #use the new variable to find the corresdoing image and copyright files in the images sub-directory

	grep -i "\"$title\"" /cs/studres/CS1007/Assessment/Reassessment/sourcedata/data/trees_public.csv >> "$target_directory/$title/data.csv" #searches for lines in the trees_public csv file that contain the description titles in quotation marks and redirecting the output into data.csv files in their appropriate sub-directory
done


