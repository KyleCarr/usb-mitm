

This Project is built using Bash

This project has been built and tested with the Libre AML-S905X-CC (Le Potato) on ubuntu 6.0.19, and is specifically built for it. Modifications can be made for it to support other boards

## Commands to run project
run this command to make the connection.bash file executable
`chmod 774 connection.bash`

run this command to make the disconnect.bash file executable
`chmod 774 disconnect.bash`

run this command to make the filetransfer.bash file executable
`chmod 774 filetransfer.bash` 

to run the application normally, run the following command
`sudo ./connection.bash`

to run the application as a system service and have it run on boot, run the following commands
`sudo systemctl daemon-reload`
`sudo systemctl enable usbMitm.service`

you can check if the application is running with the following command
`sudo systemctl is-enabled usbMitm.service`

you can turn off the application with the following command
`sudo systemctl stop usbMitm.service`