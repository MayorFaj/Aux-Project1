
# This script will read a CSV file that contains 20 new Linux users.
# This script will create each user on the server and add to an existing group called 'developers'.
# This script will first check for the existence of the user on the system, before it will attempt to create.
# The user that is being created also must also have a default home folder
# Each user should have a .ssh folder within its HOME folder. If it does not exist, then it will be created.
# For each user’s SSH configuration, we will create an authorized_keys file and add the public key





#!/bin/bash


userfile=$(cat names.csv)
PASSWORD="password"

#To ensure the user running this script has sudo privilege
if [ $(id -u) -eq 0 ]; then

#Reading files
for user in $userfile
do
    echo "user"
if id "$user" &>/dev/null
then
    echo "User Exists"
else

#Create a new user
useradd -m -d /home/$user -s /bin/bash -g developers $user
echo "New user created"
echo

# Create ssh folder in the user home folder
su - $user -c "mkdir ~/.ssh"
echo ".ssh directory created for new user"
echo

#Set user permission for ssh directory
su - $user -c "chmod 700 ~/.ssh"
echo "user permission for .ssh set"
echo

# Create authorised key file 
su - $user -c "touch ~/.ssh/authorized_keys"
echo "authorised key file created"
echo 

# Set user permission for the authorised key file created
su - $user -c "chmod 600  ~/.ssh/authorized_keys"
echo "user permission set for the authorised key file" 
echo 

 # There is need to create and set the public key for users in the server
cp -R "/home/ubuntu/shell/id_rsa.pub" "/home/$user/.ssh/authorized_keys"
echo "The Public Key to New User Account on the server has been copied"

echo "User Created"
echo
echo 

# Generate password

sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "$user"
sudo passwd -x 5 $user
        fi
    done
else
    echo "Only admin can onboard a user"
fi
