### Why:
---
The purpose of this direcotry is to provide the sensors in this project a means of transfering files to a more computationally powerful computer.
The contents of this directory are meant to be on a sensor, usually a Raspberry PI, to collect RF signals, prcess them into CSV files using a FFT program and send them off to a archiver for further operations that the sensors themselves are not equiped to do. 

### Pogram and Directory description:
---
+ **watch.sh** - This bash script is the main program for the catalogger. It expects a radio station as its first argument  and once started started this script will begin collection RF data to a .raw file using the rtl_fm software package. after it has collected a predefined size of data, defined within the bash script, it will stop the collection process and calls the **convertFM.py** program to convert the .raw data a .csv file using FFT. Once this file is created the script will call the catalog executable in records/  within catalogger/ to send the newly created .csv file to the archiver. Syntax: `bash watch.sh 97.9`
+ **raw_data/** - This directory holds the .raw data that the watch.sh script collects. After the .raw files are converted to .csv files they are deleted
+ **CSVs/** - This diretory holds the .csv files that are created from the .raw files.
+ **records/** - THis directory holds the actual catalogger code to send files off to the archivist and calculate checksums for the sent files.
  * **rpi_catalogger.c** - This is the main code for the catalogger project, It has rpi in the name becuase the code was mainly used on Raspberry PIs (Raspberry PI 3s to be specific). This code is to be called from the **watch.sh** script. In this code the address for the archivist is staticaly defined, for future rendentions I plan on adding argument passed addressed in the future. It also defines the path of the CSV file it will send off.
  * **catalogger.h** - This helper function provides the request handshake, file transfer, and socket creation for the **rpi_catalogger.c** program.
  * **chksum.h** - This helper function is implemented in the **catalogger.h** header file and provices md5checksumming to the .csv file that will be sent to the archivist to ensure file integrity across transfers.
