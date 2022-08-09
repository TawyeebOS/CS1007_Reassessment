
#!/bin/bash

target_directory=$1


if [ ! -d "$target_directory" ]; 
then
	mkdir "$target_directory"
fi


for file in sourcedata/descriptions/*
do
	sub_directory=$(head -n 1 $file | gawk 'BEGIN{FS=": "} {print $2}')
	mkdir "$target_directory/$sub_directory"

	file_title=$(echo "$file" | gawk 'BEGIN{FS="[/.]"} {print $3}')
	cp "/cs/studres/CS1007/Assessment/Reassessment/sourcedata/images/$file_title.jpg" "/cs/studres/CS1007/Assessment/Reassessment/sourcedata/images/$file_title-copyright.txt" "$target_directory/$sub_directory"

	grep -i "\"$sub_directory\"" /cs/studres/CS1007/Assessment/Reassessment/sourcedata/data/trees_public.csv >> "$target_directory/$sub_directory/data.csv"
done


