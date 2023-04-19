# Aux-Project1

## Onboard a list of Linux users from a CSV file using shell scripting.


- Create a file, "onboard.sh" containg the script

- Use the `scp` command to copy the onboard.sh file from the local machine to the home directory of the ubuntu user on the remote machine.

Run 
` scp -i MayorFaj-EC2.pem onboard.sh ubuntu@18.117.159.210:~/; `

- connect to your instance (The copied file should be there)

`mkdir shell` 

- move the onboard.sh file to the shell directory

`mv onboard.sh /home/ubuntu/shell/`

`cd shell`

- create a file to store the private key, public key, and names.csv

`touch id_rsa id_rsa.pub names.csv`

- copy the private key and public key in  the files created.


`vi id_rsa`
`vi id_rsa.pub`

- open the names.csv file, insert user names

`vi names.csv`


- Add group developers

`sudo groupadd developers`

- Give permission to the onboard.sh to be able to run the script

`sudo chmod +x onboard.sh`

Switch user to root user

`sudo su`

 - Run

 `./onboard.sh`

- Confirm users has been created

`ls -l /home`

![Users created](./images/Users%20created.png)

- Check that the developers group has been created succesfully

![group created](./images/Group%20Created.png)

For concise output, Run

`cat /etc/passwd | awk -F':' '{print $1}' | xargs -n1 groups`

- **Here is how the above command works:**
`cat /etc/passwd` displays the contents of the "/etc/passwd" file.
`awk -F':' '{print $1}'` extracts the first field of each line, which is the username, by using the colon character as the field separator.
`xargs -n1 groups` takes each username as input and runs the `groups` command, which displays the groups that the user belongs to.
The output of this command will show the group membership of each user account listed in the `/etc/passwd` file.

**NB: The /etc/passwd directory  stores information about user accounts. It contains a list of all the user accounts on the system, including their usernames, encrypted passwords (represented by an "x"), user ID (UID), group ID (GID), user information (gecos), home directory, and default shell.**

![group output2](./images/group%20created2.png)


### Test a few user randomly and ensure that you are able to connect to the server using the private key and the public key.

- Open up another terminal

- create a file and paste the private key, 

`vi Aux-Project.pem`

- Change permission for the private key file created so it is only accessible by the user.

`sudo chmod 600 Aux-Project.pem`

- To connect to server, Run

`ssh -i Aux-Project.pem Mayowa@18.117.159.210`

![server connection successful](./images/User%20connected%20to%20server%20successfully.png)

