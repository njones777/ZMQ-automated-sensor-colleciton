### Why:
---
The purpose of these programs were to provide the my team with a means of 
sending files and to help test bandwidth, latency and, program execution time
across multipel different types of devices. Such devices included, Raspberry Pis,
HPC systems, laptops, and micro controllers. These programs took advantage of [ZMQ](https://zeromq.org/),
a high-peformance messaging library that provides sockets and patterns for building
distributed and scalable applications. It helped to simply the complexity of our projects
interpocess communiction and networking by providing a lightweigh and flexible framework.

### Progam descriptions:
---
+ **archiver** - contains file to run the archiver program. This is a 
+ **receiver.h** - header file for request.c to make code look cleaner and provide additonal functionality
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
