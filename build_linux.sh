#!/bin/bash

COLOR='\033[0;36m'
WARNING='\033[0;41m'
NOCOLOR='\033[0m'

IDE='MISSING'

printf "\n${COLOR}--------------------\nngPAWS linux builder\n--------------------${NOCOLOR}\n\n"
printf "${COLOR}You need Lazarus, git, and gcc installed on your system${NOCOLOR}\n\n"
printf "${COLOR}*${NOCOLOR} Deleting previous directories\n"

#Start the build

#build ngPAWS
if [ -d "build" ]; then 
  printf "${COLOR}*${NOCOLOR} Deleting build directory\n"
  rm -Rf build
fi

if [ -d "Release-linux-en" ]; then 
  printf "${COLOR}*${NOCOLOR} Deleting Release-linux-en directory\n"
  rm -Rf Release-linux-en
fi
if [ -d "Release-linux-es" ]; then 
  printf "${COLOR}*${NOCOLOR} Deleting Release-linux-es directory\n"
  rm -Rf Release-linux-es
fi

if [ -d "Release-linux" ]; then 
  printf "${COLOR}*${NOCOLOR} Deleting Release-linux directory\n"
  rm -Rf Release-linux
fi

printf "${COLOR}*${NOCOLOR} Creating build and release directories\n"
mkdir build
mkdir Release-linux

if [ "$(which lazbuild)" = "" ]; then
   printf "\n${WARNING}lazbuild coudn't be found.${NOCOLOR} Please install Lazarus\n"
else
   printf "${COLOR}*${NOCOLOR} Building IDE (may take a while)\n"
   cp -R newIDE build/newIDE
   lazbuild build/newIDE/ngpaws_linux.lpi
   rc=$?; if [ "$rc" != "0" ]]; then exit $rc; fi
   printf "${COLOR}*${NOCOLOR} Moving IDE to release directory\n"
   mv build/newIDE/ngpaws Release-linux/ngpaws
   IDE='INCLUDED'
fi

if [ "$(which gcc)" = "" ]; then
   printf "\n${WARNING}gcc coudn't be found.${NOCOLOR} Please install it\n\n"
else   
   printf "\n${COLOR}*${NOCOLOR} Building npgc compiler\n\n"
   cp -R compiler build/compiler/
   make -C build/compiler/
   rc=$?; if [ "$rc" != "0" ]; then exit $rc; fi


   #build txtpaws
   if [ -d "txtpaws" ]; then
      printf "\n${COLOR}*${NOCOLOR} txtpaws project directory exists\n"
   else
      if [ "$(which git)" = "" ]; then
         printf "\n${WARNING}git coudn't be found.${NOCOLOR} Please install git\n\n"
         exit
      fi
      printf "\n${COLOR}*${NOCOLOR} Cloning txtpaws from GitHub\n"
      git clone https://github.com/Baltasarq/txtpaws/
   fi
   
   printf "\n${COLOR}*${NOCOLOR} Building txtpaws\n\n"
   make -C txtpaws/src/ clean
   rc=$?; if [ "$rc" != "0" ]; then exit $rc; fi
   make -C txtpaws/src/ txtpaws
   rc=$?; if [ "$rc" != "0" ]; then exit $rc; fi

   printf "\n${COLOR}*${NOCOLOR} Prepare files for Release\n"
   mv $(find -iname ngpc -type f -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f 2) Release-linux/ngpc
   cp txtpaws/src/txtpaws Release-linux/txtpaws
   cp -R jsl example-code extra_langs installation_aux_files/* plugins Release-linux/
   
   cp -R Release-linux Release-linux-es
   mv Release-linux Release-linux-en
   
   printf "${COLOR}*${NOCOLOR} Setting Spanish database as default for Release-linux-es\n"
   mv Release-linux-es/database.start.spanish Release-linux-es/database.start
   
   printf "${COLOR}*${NOCOLOR} Setting English database as default for Release-linux-en\n"
   mv Release-linux-en/database.start.english Release-linux-en/database.start

   printf "${COLOR}*${NOCOLOR} Cleaning build folder\n\n"
   if [ -d "build" ]; then
      rm -Rf build
   fi 
   
   printf "${COLOR}* English release is in Release-linux-en folder\n"
   printf "* Spanish release is in Release-linux-es folder\n\n"

   printf "* IDE build is ${NOCOLOR}${WARNING}${IDE}${NOCOLOR}\n"
   
   printf "\n${COLOR}--------------------\nDone\n--------------------${NOCOLOR}\n\n";
fi
