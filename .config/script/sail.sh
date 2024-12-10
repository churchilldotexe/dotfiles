#!/bin/bash

echo "Laravel Sails setup:"
echo "This will create a new folder"
echo "with a name based on your project name"
echo "at your current directory"
echo "-----------------------------"

# Prompt for project name with a default value
read -p "What is the name of your Project? [example-app]: " project_name

# Use default if no input is provided
if [[ -z "$project_name" ]]; then
    project_name="example-app"
fi

# Execute Laravel Sail setup
curl -s https://laravel.build/"$project_name" | bash
