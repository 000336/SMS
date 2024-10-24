
#!/bin/bash


function grepbyname(){
if [ $# -eq 0 ];
then
  echo "$0: USAGE: INPUT {APPLICATION TO KILL:#}"

elif [ $# -gt 1 ];
then
  echo "$0: GREP NUMBER BY NAME METHOD ONLY TAKES MAXIMUM ONE POSITIONAL ARGUMENT"
  echo "$0: USAGE: INPUT {NAME TO SEARCH:#}"
fi

name=$1
data=$(cat '/home/user/Desktop/numero.txt' | grep $name)
echo "${data%% *}"
}


function ssend(){
if [ $# -eq 0 ];
then
  echo "$0: USAGE: INPUT {PHONE NUMBER:#, TEXT: #, MODEM: #=ANY}"

elif [ $# -gt 3 ];
then
  echo "$0: SEND METHOD ONLY TAKES MAXIMUM THREE POSITIONAL ARGUMENTS"
  echo "$0: USAGE: INPUT {PHONE NUMBER:#, TEXT: #, MODEM: #=ANY}"
fi

n=$1
text=$2

if ! [[ $n =~ ^-?[0-9]+$ ]];
then 
   data=$(cat '/home/user/Desktop/numero.txt' | grep $n)
   n="${data%% *}"
fi

if [ ! $3 ];
then
  modem='any'
else
  modem=$3
fi

rst=$(sudo mmcli -m $modem --messaging-create-sms="text='$text', number='$n'")
no=$(echo $rst|grep -Eo '[0-9]+$')
sudo mmcli -s $no --send 1> /dev/null 2>&1
sudo mmcli -m $modem --messaging-delete-sms=$no 1> /dev/null 2>&1
}



function srecv(){
if [ $# -gt 1 ]; then
  echo "$0: SEND METHOD ONLY TAKES MAXIMUM ONE POSITIONAL ARGUMENTS"
  echo "$0: USAGE: INPUT {MODEM: #=ANY}"
fi

if [ ! $1 ]; then
  modem='any'
else
  modem=$1
fi

rst=$(sudo mmcli -m $modem --messaging-list-sms)
rst=(${rst//"(received)"/})

lsms=()
for i in ${rst[*]}; do
  nsms=$(echo ${i}|grep -Eo '[0-9]+$')
  rsms=$(sudo mmcli -s $nsms 2> /dev/null)
  rsms=$(echo ${rsms// /-space-})
  rsms=(${rsms//'|'/})

  numb_send=${rsms[3]}
  text_send=${rsms[4]}
  time_send=${rsms[10]}

  numb_send=$(echo ${numb_send//-space-/' '})
  numb_send=$(echo ${numb_send/'Content number: '/''})
  text_send=$(echo ${text_send//-space-/' '})
  text_send=$(echo ${text_send/'text: '/''})
  time_send=$(echo ${time_send//-space-/' '})
  time_send=$(echo ${time_send/'timestamp: '/''})

  if [ ! $numb_send ]; then
     numb_send=""
  else
     csms="FROM: $numb_send, TIME_STAMP: $time_send, MESSAGE: $text_send"
     lsms[${#lsms[*]}]=$csms
     sudo mmcli -m $modem --messaging-delete-sms=$nsms 1> /dev/null 
  fi
done

len=${#lsms[@]}
for ((i=len-1; i>=0; i--)); do
    echo "${lsms[i]}"
done
}



function sms_display(){
rst=$(srecv)
if [ ! $rst ]; then
   rst=""
   sleep 1s
else
   (notify-send --app-name=SMS "MESSAGE" "\"$rst"\") 1> /dev/null
fi
}



function wwan_up(){
(notify-send --app-name="WWAN" "$(pkexec sudo nmcli c up CELLULAR_CONNECTION)" )
}



function wwan_off(){
(notify-send --app-name="WWAN" "$(pkexec sudo nmcli c down CELLULAR_CONNECTION)" )
}



function killapp(){
if [ $# -eq 0 ];
then
  echo "$0: USAGE: INPUT {APPLICATION TO KILL:#}"

elif [ $# -gt 1 ];
then
  echo "$0: KILL BY NAME METHOD ONLY TAKES MAXIMUM ONE POSITIONAL ARGUMENT"
  echo "$0: USAGE: INPUT {APPLICATION TO KILL:#}"
fi

name=$1
data=$(ps -e|grep $name)
data=$(echo $data | tr " " "\n")
pkexec sudo;
for i in $data; do
   if [[ $i =~ ^[0-9]+$ ]]
   then
     kill $i;
fi
done
}

