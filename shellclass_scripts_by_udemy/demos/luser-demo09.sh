#!/bin/bash

# This script demonstrates the case statement.

# Instead of an if statement like this, consider using a case statement instead.
# if [[ "${1}" = 'start' ]]
# then
#   echo 'Starting.'
# elif [[ "${1}" = 'stop' ]]
# then
#   echo 'Stopping.'
# elif [[ "${1}" = 'status' ]]
# then
#   echo 'Status:'
# else
#   echo 'Supply a valid option.' >&2
#   exit 1
# fi

#If you find yourself writing a large if-elif statement comparing different values against the exact same variable, consider using a case statement in its place. You can check the contents of a variable against a list of patterns that you specify. You can do exact matches by specifying the exact string that you're looking in place pattern. You can also perform matches with patterns that include asterisk(*), question marks(?), and square brackets[...]. To perform the same set of actions against multiple patterns, separate each pattern with a pipe.
# This ideal format of a case statement follows.
# case "${1}" in
#   start)
#     echo 'Starting.'
#     ;;
#   stop)
#     echo 'Stopping.'
#     ;;
#   status|state|--status|--state)
#     echo 'Status:'
#     ;;
#   *)
#     echo 'Supply a valid option.' >&2
#     exit 1
#     ;;
# esac

# In my opinion, it's harder to read a case statement or an if statement or really anything else without indentation, so, I don't recommend the below approach. If you're only executing one command following a pattern, it's a common practice to keep that command on the same line as the pattern match and to also include the closing double semicolons on that same line as well.
# Here is a compact version of the case statement.
case "${1}" in
  start) echo 'Starting.' ;;
  stop) echo 'Stopping.' ;;
  status) echo 'Status:' ;;
  *)
    echo 'Supply a valid option.' >&2
    exit 1
    ;;
esac

