# SMS
Sending SMS via modem by using mmcli commands in a faster way. Including search number by name and use non-specific modem. 


# FIRST-USE INSTALLATION
1. Clone the script to ANY fixed directory  <br>
2. Source the file  <br>
3. [optional] Create a file for storing numbers with names; for example, numbers.txt
   
   Example:       XXXXXXXXXXX     NAME    NAME-IN-SHORT    SPECIFICATION-IF-THERE-IS-ANY  <br>
                  XXXXXXXXXXX     NAME    NAME-IN-SHORT    SPECIFICATION-IF-THERE-IS-ANY

   store this txt and change the file name inside the script.
   You may search for names by using any string provided by yourself after their phone numbers.
   Or even use ssend with $NAME, $MESSAGE.

DON'T FORGET TO GIVE SUDO ACCES TO MMCLI BY ADDING IT TO SUDOERS
   
# PROBLEMS:
   OBLIGATION TO ADD " " TO MESSAGE  <br>
   CANNOT INPUT ' IN A MESSAGE
