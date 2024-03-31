#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name who is going to be using this account.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user.
# By the way, you may have noticed that I put the $COMMENT variable in quotes. The reason I did that is because this $COMMENT variable may contain spaces. When we prompt them to enter the name of the person that the account is for, typically people have first and last names if not more names. So, someone will type in 'Jane Smith' and that will be the information that is stored in that one $COMMENT variable. But again, there's a space. Now, it's important to point out here by putting something in quotes, it gets treated as a single argument or a single item and not separate arguments or separate items.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login. Force the user to change their password for the 1st time they login  
passwd -e ${USER_NAME}
