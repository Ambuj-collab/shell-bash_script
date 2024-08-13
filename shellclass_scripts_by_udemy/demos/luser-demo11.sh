#!/bin/bash

# This script generates a random password.
# The user can set the password length with -l and add a special character with -s.
# Verbose mode can be enabled with -v.

usage() {
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.' >&2
  echo '  -l LENGTH  Specify the password length.' >&2
  echo '  -s         Append a special character to the password.' >&2
  echo '  -v         Increase verbosity.' >&2
  exit 1
}

log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

# Set a default password length. Because user can optionally specify a password length with -l option. This default value will be overridden with whatever the user provides if they decide to specify a password length
LENGTH=48

# Remember, we have to tell getopts what options are valid. Here, we're going to allow the -v option, the -l option and the -s option. That's why we have the characters 'vls' in the optstring. If you want to make an option have a mandatory value then follow that option with a colon. By using vl:s, we are saying that the -l option must be followed with an argument. Now, we're going to use a case statement to process our options. When an option requires an argument, getopts places that argument into the shell variable OPTARG. By the way, you could have used an asterisk(*) as the catchall pattern in the case statement but getopts is giving us a single character option at a time. So I decided to use the pattern for a single character which is the question mark(?).
while getopts vl:s OPTION
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      log 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?)
      usage
      ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
  usage
fi

log 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password:'

# Display the password.
echo "${PASSWORD}"

exit 0

# You can run the script like './luser-demo11.sh -sv' or './luser-demo11.sh -vs' or './luser-demo11.sh -s -v' or './luser-demo11.sh -v -s'
# Now, let's try specifying a length. So, you can also run './luser-demo11.sh -l 8' or './luser-demo11.sh -sl 8'
# By the way, something that 'getopts' handles for us here './luser-demo11.sh -vs'is convention where you can not only do '-sv' but you can also do '-vs' which is the same as '-v -s' or '-s -v'.
