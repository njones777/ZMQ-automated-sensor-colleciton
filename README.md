### Why:
---
The purpose of these programs were to provide the my team with a means of 
sending files and to help test bandwidth, latency and, program execution time
across multipel different types of devices. Such devices included, Raspberry Pis,
HPC systems, laptops, and micro controllers. These programs took advantage of [ZMQ](https://zeromq.org/),
a high-peformance messaging library that provides sockets and patterns for building
distributed and scalable applications. It helped to simply the complexity of our projects
interpocess communiction and networking by providing a lightweigh and flexible framework.

## Key Terms:
**RF** - Radio Frequency

**FFT** - An algorithm that computes the discrete Fourier transform (DFT) of a sequence, or its inverse (IDFT)

### Progam descriptions:
---
+ **archiver** - Contains file and directories to run the archiver program. The archiver is a file collection program that is always waiting for sensors to send it CSV files produced from RF signal collection that has been turned into a CSV though a FFT program. 
+ **catalogger** - This contains files and directories to run the catalogger program. The catalogger is a data collection program that will routinley collect RF singal data run a FFT program on it to convert it to a CSV file and send it to the catalogger
    + watch.sh - This bash script is the main program for the catalogger. Once started this script will begin collection RF data to a .raw file using the rtl_fm software package. after it has collected a predefined size of data, defined within the bash script, it will stop the collection process and calls the convertFM.py program to convert the .raw data a .csv file using FFT. Once this file is created the script will call the catalog executable in the records directory within the catalogger direcotry to send the newly created .csv file to the archiver.
+ **supplicant.c** - waits and listens for a file request from a requester in order to provide it with a file or files
 if you are doing a muli file-bandwidth test
+ **sender.h** - header file for supplicant.c to make code cleaner and provide additonal functionality for supplicant

### Syntax:
---
+ **Make executables:** ``` Make ```
    + **Compile executables individually:** ``` gcc -o zmq_sup suppliant.c -I./ -lzq ```
+ **Start supplicant and wait for request(s):** ``` ./zmq_sup ```
+ **Send a file request to the supplicant:** ```./zmq_req 192.168.0.1 /path/to/file/on/supplicant /local/path/to/write/to```
   + The requester expects the ip address of the supplicant, the path of the file on the supplicant you are requesting
     and the local path you want the requester to write to.
