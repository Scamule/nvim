#!/bin/bash

############### INFORMATION ###############
# Delete anything you don't need
# This file includes:
#   Style variables
#   print_aligned() - used by show_help()
#   show_help()
#   Spinner animation scripts
#     start_spinner
#     success_spinner
#     fail_spinner
#     cleanup_spinner
#     run_task
#   Argument parsing and reading
#
###########################################

### Switches
# (i don't know what to call them)
# This line makes the script exit whenever a command returns a fail status (!0)
# set -e

### Variables
# Any string requiring escape characters should be single quote strings ('Here\nI\nAm')
# Using $ on them expands then into their value abiding by pure value (\n is a newline and \033 is escape)
SCRIPT_NAME="${BASH_SOURCE[0]##*/}" # '##' for longest matching pattern, '#' for shortest
# Update this with the PID of a spinner
SPINNER_PID=
# Text style
RESET=$'\033[0m'
BOLD=$'\033[1m'
DIM=$'\033[2m'
ITALIC=$'\033[3m'
UNDERLINE=$'\033[4m'
STRIKETHROUGH=$'\033[9m'
INVERT=$'\033[7m'

# Text colors
BLACK=$'\033[30m'
RED=$'\033[31m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
BLUE=$'\033[34m'
PURPLE=$'\033[35m'
CYAN=$'\033[36m'
WHITE=$'\033[37m'
BLACK_BRIGHT=$'\033[90m'
RED_BRIGHT=$'\033[91m'
GREEN_BRIGHT=$'\033[92m'
YELLOW_BRIGHT=$'\033[93m'
BLUE_BRIGHT=$'\033[94m'
PURPLE_BRIGHT=$'\033[95m'
CYAN_BRIGHT=$'\033[96m'
WHITE_BRIGHT=$'\033[97m'

# Background colors
BLACK_BACKGROUND=$'\033[40m'
RED_BACKGROUND=$'\033[41m'
GREEN_BACKGROUND=$'\033[42m'
YELLOW_BACKGROUND=$'\033[43m'
BLUE_BACKGROUND=$'\033[44m'
PURPLE_BACKGROUND=$'\033[45m'
CYAN_BACKGROUND=$'\033[46m'
WHITE_BACKGROUND=$'\033[47m'
BLACK_BRIGHT_BACKGROUND=$'\033[100m'
RED_BRIGHT_BACKGROUND=$'\033[101m'
GREEN_BRIGHT_BACKGROUND=$'\033[102m'
YELLOW_BRIGHT_BACKGROUND=$'\033[103m'
BLUE_BRIGHT_BACKGROUND=$'\033[104m'
PURPLE_BRIGHT_BACKGROUND=$'\033[105m'
CYAN_BRIGHT_BACKGROUND=$'\033[106m'
WHITE_BRIGHT_BACKGROUND=$'\033[107m'

### Functions
# function_name()
# - This is a function comment and you should follow how this looks
#   This is a function description
#   Calling a function looks like this:
#   function_name "arg1" "arg2" arg3_num
# - Globals:
#     GLOBAL_VARIABLE - This variable exists elsewhere and I edit it
# - Arguments:
#     $1 - Variable given to the function, a string or a number
#     $2 - You can have more than one
# - Returns:
#     Returns 0 if I love cheese, 1 otherwise
function_name() {
  do_i_love_cheese="yes"
  this_will_be_global="yes"
  local this_will_not_be_global="yes"
  # Note: using local declaration counts as an execution, so $? will update to 0 on success of the local variable declaration
  local will_this_return_zero="yes"
  command='ls -l'
  silent_command_output=$(eval "$command" 2>&1)
  exit_code=$?
  # 'command &' runs command in the background
  # You can get its PID using $! on the next line
  return 0
}

# print_aligned()
#   This function is a print function that aligns the input nicely for help
# - Arguments:
#     $1 - the stirng to print in the format of the following:
#       "-<Argument Letter>
#       Informational text line 1
#       Informational text line 2
#       etc."
print_aligned() {
  local input="$1"
  # Padding string for flag
  local flag_padding_str=$(printf "%2s" "") 
  # Padding string for first line
  local line1_padding_str=$(printf "%1s" "") 
  # Padding string for after lines
  local afterline_padding_str=$(printf "%5s" "")
  # While loop to print lines
  local count=0
  while IFS= read -r line; do
    # Print based on what line
    if [ "$count" -eq 0 ]; then
      # Print the flag
      printf "%s${BOLD}%s${RESET}" "$flag_padding_str" "$line"
    elif [ "$count" -eq 1 ]; then
      # Print first line
      printf "%s%s\n" "$line1_padding_str" "$line"
    else
      # Print any other lines
      printf "%s%s\n" "$afterline_padding_str" "$line"
    fi
    ((count++))
  done <<< "$input"
}

# show_help()
# - Shows the help screen
#   Call when -h or --help are given
show_help() {
  local template_option_str_a="-a
  Informational text goes here
  This will run the '${BOLD}${SCRIPT_NAME} example${RESET}' command
  It won't actually do that, this is an example"

  local template_option_str_c="-c
  Information C: This is in the ${BOLD}third${RESET} string
  You'll see when you run this"

  local template_option_str_b="-b
  Information B: This is in the ${BOLD}second${RESET} string"

  # printf "--" thinks -- is an argument, so you need to use printf -- ""
  # The -- argument indicates no more flags
  printf -- "---------------------- %s${SCRIPT_NAME}%s ----------------------\n" "$BOLD" "$RESET"
  printf "Usage: %s${SCRIPT_NAME}%s [options]\n\n" "$BOLD" "$RESET"

  printf "This is where you include information text for how the script works.\n"
  printf "You can use styling here, too. Like %sthis%s.\n" "$UNDERLINE" "$RESET"
  printf "Or %sthis%s!\n" "$BOLD" "$RESET"
  printf "%sNote:%s Note goes here\n\n" "$BOLD" "$RESET"

  printf "Options:\n"
  # You should list the option in alphabetical order
  print_aligned "$template_option_str_a"
  print_aligned "$template_option_str_b"
  print_aligned "$template_option_str_c"

  printf -- "---------------------------------------------------------\n"
  exit 0
}

### Spinner animation scripts

# start_spinner()
# - Starts the spinner animation
#   Uses trap ... EXIT to call cleanup_spinner() to restore the cursor on a Ctrl-C
# - Arguments:
#     $1 - The text to be displayed after the spinner
# - Example:
#     start_spinner "Loading"
start_spinner() {
  trap cleanup_spinner EXIT
  local text="$1"
  local frames=('/' '-' '\' '|')
  # This hides the cursor so it doesn't blink like crazy
  tput civis 
  (
    while true; do
      for frame in "${frames[@]}"; do
        printf "\r[$frame] $text"
        sleep 0.1
      done
    done
  ) &
  SPINNER_PID=$!
}

# success_spinner()
# - Stops the spinner animation with a checkmark to indicate success
#   Restores the cursor and removes trap on exit
# - Arguments:
#     $1 - The text to be displayed after the checkmark
success_spinner() {
  local text="$1"
  # This block is to silently kill the process
  # wait forces the process to terminate inside the block, instead of the messages leaking out later
  { kill "$SPINNER_PID"; wait $SPINNER_PID; } 2>/dev/null
  SPINNER_PID=""
  tput cr # Go to start of line
  tput el # Delete content until end of line
  printf "\r[%s✓%s] $text\n" "$GREEN" "$RESET"
  tput cnorm # Restore cursor
  trap - EXIT # Remove trap EXIT
}

# fail_spinner()
# - Stops the spinner animation with an x to indicate failure
#   Restores the cursor and removes trap on exit
# - Arguments:
#     $1 - The text to be displayed after the x
fail_spinner() {
  local text="$1"
  { kill "$SPINNER_PID"; wait $SPINNER_PID; } 2>/dev/null
  tput cr # Go to start of line
  tput el # Delete content until end of line
  printf "\r[%s✗%s] $text\n" "$RED" "$RESET"
  tput cnorm # Restore cursor
  trap - EXIT # Remove trap EXIT
}

# cleanup_spinner()
# - Removes the spinner from the screen and restores the cursor to it's former glory
cleanup_spinner() {
  tput cnorm
  # Kill process if it is running
  if [ -n "$SPINNER_PID" ]; then
    kill "$SPINNER_PID" 2>/dev/null
  fi
}

# run_task
# - Runs a command that has output and spits it out after editing the text
#   This is only used for simple commands
#   If you need to check exit codes, use this function as a guide
# - Globals:
#     SPINNER_PID - the pid of the spinner process
# - Arguments:
#     $1 - Command to be run
#     $2 - Loading text
#     $3 - Success text
#     $4 - Fail text
#     $5 - Style for the status text
#     $6 - Style for text the command outputs
# - Example:
#     run_task "ls" "Running ls" "ls success!" "ls failed!" "" "${BOLD}${RED}" "true"
run_task() {
  local command="$1"
  local loading_text="$2"
  local success_text="$3"
  local fail_text="$4"
  local status_styles="$5"
  local command_styles="$6"
  local do_command_output="$7"

  start_spinner "$loading_text" &
  SPINNER_PID=$!

  command_output=$(eval "$command" 2>&1)
  exit_code=$?

  if [ $exit_code -eq 0 ]; then
    success_spinner "${status_styles}${success_text}${RESET}"
  else
    fail_spinner "${status_styles}${fail_text}${RESET}"
  fi
  if [ "$do_command_output" = "true" ]; then
    printf "%s$command_output%s\n" "$command_styles" "$RESET"
  fi
}

# Unpack any grouped flag arguments
args=()
for arg in "$@"; do
  if [[ "$arg" =~ ^-[a-zA-Z0-9]+$ ]]; then
    # Strip front dash
    clean_flags="${arg#-}"
    # Character loop through clean_flags
    while [ -n "$clean_flags" ]; do
      char="${clean_flags:0:1}"
      args+=("-$char")
      # Remove first character from string
      clean_flags="${clean_flags:1}"
    done
  else
    # Add long word flags like --help or even just words
    args+=("$arg")
  fi
done
set -- "${args[@]}"

# Check arguements
execute_story=1
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -n|--no)
      execute_story=0
      ;;
    --is)
      printf "Hello inspector! You know how to read this file!\n"
      exit 0
      ;;
    *)
      printf "%s%sERROR%s\n" "$RED" "$BOLD" "$RESET"
      printf "Invalid flag \"$1\", use %s${SCRIPT_NAME} --help%s to show options\n" "$BOLD" "$RESET"
      exit 1
      ;;
  esac
  shift
done

# Run script
printf -- "---------------------- %s${SCRIPT_NAME}%s ----------------------\n" "$BOLD" "$RESET"

# # You can check if an app is open and open it if you need to
# app_path="/Applications/App.app" # App path to open
# app_name="My App" # Name of app when checking the PID
# 
# # Check if App is running and open it if it is not running
# app_was_open=true
# app_pid=0
# if ! app_command 1>/dev/null 2>/dev/null; then
#   app_was_open=false
#   printf "App is not open\n"
#   start_spinner "Opening..." &
#   SPINNER_PID=$!
#   if ! open -n "$app_path"; then
#     fail_spinner "Failed"
#     printf "App does not exist at path %s\n" "$app_path"
#     exit 1
#   fi
#   # Check for PID, loop until found, app is still opening
#   attempt_number=0
#   while ! app_pid=$(pgrep -x "$app_name"); do
#     sleep 0.1
#     ((attempt_number++))
#     if [ "$attempt_number" -gt 50 ]; then
#       fail_spinner "Failed"
#       printf "Too many attempts, exiting...\n"
#       exit 1
#     fi
#   done
#   success_spinner "Opened App"
# fi

if [ "$execute_story" -eq 0 ]; then
  exit 0
fi

start_spinner "This is what a running start_spinner looks like"
sleep 4
success_spinner "This is what success_spinner looks like!"
sleep 1

start_spinner "Loading failure"
sleep 1
fail_spinner "This is what fail_spinner looks like!"
sleep 1

printf "You can also ask for input from the user!\n"
name=
read -p "Enter a name and I will try and guess it: " name

start_spinner "Reading your mind..."
sleep 3
success_spinner "Done thinking"
sleep 1
printf "You entered ${name}!\nSpooky!\n"
sleep 1

printf "You can also enter sensitive information!\n"
secret=
read -s -p "Enter a secret: " secret
printf "\n"

start_spinner "Reading your mind again..."
sleep 3
success_spinner "Done thinking, I'm so good at this"
sleep 1
printf "Your secret is ${secret}! Ew!\n"
sleep 1

printf "This is the end of my time for now, inspect this file with vim ${SCRIPT_NAME} to see all of the other stuff you can do in a bash script.\n"
sleep 2
printf "Toodles!\n"
sleep 1

start_spinner "Deleting system32..."
sleep 5
fail_spinner "I'm just a little tired, I couldn't do it, I was really close though, watch out!"
sleep 3

printf "Anyways, adios!\n"

# if [ "$app_was_open" = false ]; then
#   printf "Closing App...\n"
#   kill $app_pid
# fi

printf "%s---------------------------------------------------------\n" "$RESET"
