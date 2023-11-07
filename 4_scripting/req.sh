#!/bin/bash
#TODO: check for permissions

# check_alt_txt() {
#     if 
# }

if [ $# -lt 1 ]; then
    echo "You must pass at least one argument. Type './req.sh help' to see the available commands."
    exit 1
fi

# Placeholder txt file name
txt_path="requirements.txt"

# If a specific txt file name was provided, save it
if [ $# -gt 2 ] && { [ "${@: -2:1}" = "-f" ] || [ "${@: -2:1}" = "--file" ]; }; then
    txt_path="${!#}"
    # last="${!#}"
    # if [[ $last != ./*.txt ]]; then
    #     echo "Invalid input or text file. The last argument must be of the form ./[text name].txt"
    #     exit 1
    # fi

    # txt_path="${last#./}"
    
fi

case "$1" in
    install)
        if [ -d "$txt_path" ]; then
            echo "Could not find txt file in the current directory. Type './req.sh help' to see this command's usage."
            exit 1
        fi
        echo "Analyzing dependencies in '$txt_path'"
        while read -r line || [ -n "$line" ]; do
            echo "Processing '$line'"
            if ! dpkg -s "$line" >/dev/null 2>&1;
            then
                if apt install "$line"; then
                    echo "Installed package $line"
                else
                    echo "WARNING: skipped package $line because it was not found."
                fi
            else
                echo "Package '$line' was already installed."
            fi
        done < "$txt_path"
    ;;
    verify)
        if [ -d "$txt_path" ]; then
            echo "Could not find txt file in the current directory. Type './req.sh help' to see this command's usage."
            exit 1
        fi

        echo "Missing dependencies:"

        while read -r line || [ -n "$line" ]; do
            if ! dpkg -s "$line" >/dev/null 2>&1; then
                echo "$line"
            fi
        done < "$txt_path"
    ;;
    add)
        if [ -z "$2" ]; then
            echo "Please specify a dependency to add"
            exit 1
        fi 

        if grep -w "$2" "$txt_path" >/dev/null 2>&1 ; then
            echo "Dependency $2 was already present in $txt_path"
            exit 0
        fi

        # If, in the end, the dependency was not present, add it
        echo -e "$2" >> "$txt_path"

        echo "Added $2 to $txt_path"
        exit 0
    ;;
    remove)
        if [ -z "$2" ]; then
            echo "Please specify a dependency to add"
            exit 1
        fi 

        if ! grep -w "$2" "$txt_path" >/dev/null 2>&1 ; then
            echo "Dependency $2 was not present in $txt_path"
            exit 0
        fi

        # If, in the end, the dependency was present, remove it
        sed -i "/$2/d" "$txt_path"
        echo "Removed $2 from $txt_path"
        exit 0
    ;;
    help)
        echo "./req.sh install : Installs missing dependencies found at requirements.txt"
        echo "./req.sh verify : Prints dependencies found at requirements.txt which are not installed"
        echo "./req.sh add <dependency> # it should add a dependency to the requirements.txt and install it"
        ./req.sh remove <dependency> # it should remove the dependency from the requirements.txt file
        ./req.sh install --file ./req.txt # it should be able to override the dependency file on every command
        ./req.sh install -f  ./req.txt # it should be able to override the dependency file on every command
    ;;
    *)
        echo "'$1' is not a valid option."
        exit 1
    ;;
esac