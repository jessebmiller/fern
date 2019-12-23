#! /bin/zsh

# Install dotfiles anything in this folder starting with a .
for file in ~/mack/dotfiles/.*; do

    destinationFile="$HOME/$(basename $file)"

    # If the destination file exists replace it. no mercy.
    if [ -e $destinationFile ]
    then
        echo "Removing   $destinationFile"
        rm $destinationFile
    fi

    echo "Installing $destinationFile"
    ln -s $file $destinationFile

done

