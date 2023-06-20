#!/bin/sh

# Set the IFS (Internal Field Separator) to ':' to split the PATH variable correctly
IFS=":"

# Check if no arguments are provided
if [ $# -eq 0 ]; then
  echo >&2 "usage : which [−a] name ..."
  exit 1
fi

print_all_paths=0

# Check if the first argument is the -a option
if [ "$1" = "-a" ]; then
  print_all_paths=1
  shift  # Remove the -a option from the arguments
fi

# Loop through each command provided as an argument
for command in "$@"; do
  found=0  # Flag to track if the command is found

  # Check if the command is an absolute path
  if [ "${command#/}" != "$command" ]; then
    # Check if the absolute path exists and is executable
    if [ -x "$command" ]; then
      echo "$command"
      found=1
      if [ "$print_all_paths" -eq 0 ]; then
        break  # Stop searching if -a option is not provided
      fi
    fi
  else
    # Loop through each directory in the PATH variable
    for directory in $PATH; do
      # Construct the full path to the command
      full_path="$directory/$command"

      # Check if the command exists and is executable
      if [ -x "$full_path" ]; then
        echo "$full_path"
        found=1
        if [ "$print_all_paths" -eq 0 ]; then
          break  # Stop searching if -a option is not provided
        fi
      fi
    done
  fi

  # If the command is not found, display an appropriate message
  if [ "$found" -eq 0 ]; then
    echo "which: $command: Command not found."
  fi
done
