

This Project is built using C11 and the gcc compiler

## Commands to run project
Run this command in the terminal of the Libre potato to get access to the correct C headers for code compilation:
`sudo apt install linux-headers-generic`

to compile the code and get the output file, open the terminal and run the following command within the project directory:
`make`

Load the module into the kernel using the following command:
`sudo insmod Main.ko`

view module info using this command:
`modinfo Main.ko`

View the Kernel log messages using the following command:
`tail /var/log/kern.log`

Remove module from kernel with the following command:
`sudo rmmod Main`
## Reccomended Extensions
- C/C++
- CMake
- Github Pull Requests and Issues
- Prettier
- Embedded Linux Kernel Dev