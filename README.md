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

# FEATURES:
   function grepbyname: To grep the number associated with a specific name or description registered in phonenumber.txt
   
   function grepbynumber: To grep the name associated with a specific phone number registered in phonenumber.txt
   
   function ssend: To send a sms to provided number, may select modem to use

   function srecv: To receive sms on any / selected modem

   function sdisp: To display in notification center all sms received. This function may be used in a loop in order to display sms notification in real-time, for example, "while true; do sdisp; sleep 1; done;

   function wwan_up: To turn WWAN connection up. This function required to register a cellular connection point first.

   function wwan_down: To turn WWAN connection down. Same as before. 

   
# PROBLEMS:
   OBLIGATION TO ADD " " TO MESSAGE  <br>
   CANNOT INPUT ' IN A MESSAGE
