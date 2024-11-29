#!/bin/bash

COLOR='\033[0;36m'
NOCOLOR='\033[0m'

printf "\n\n${COLOR}--------------------\nngPAWS linux builder\n--------------------${NOCOLOR}\n\n";
printf "${COLOR}*${NOCOLOR} You need Lazarus, git, and gcc installed on your system\n\n";
if [ $(which lazbuild) = "" ]; then
   printf "lazbuild coudn't be found. Please install Lazarus"
else
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

   if [ -d "Release-linux-es" ]; then 
      printf "${COLOR}*${NOCOLOR} Deleting Release-linux-es directory\n"
      rm -Rf Release-linux-es
   fi


   printf "${COLOR}*${NOCOLOR} Building IDE (may take a while)\n"
   mkdir build
   cp -R newIDE build/newIDE
   lazbuild build/newIDE/ngpaws_linux.lpi
   rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


   printf "\n${COLOR}*${NOCOLOR} Building npgc compiler\n"
   cp -R compiler build/compiler/
   make -C build/compiler/
   rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi


   #build txtpaws
   if [ -d "txtpaws" ]; then
      printf "\n${COLOR}*${NOCOLOR} txtpaws project directory exists\n"
   else
      printf "\n${COLOR}*${NOCOLOR} Cloning txtpaws\n"
      git clone https://github.com/Baltasarq/txtpaws/
   fi
   
   make -C txtpaws/src/ clean
   rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
   make -C txtpaws/src/ txtpaws
   rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
   
   #prepare the Release files
   if [ -d "Release-linux" ]; then
      printf "\n${COLOR}*${NOCOLOR} Deleting Release directory\n"
      rm -Rf Release-linux
   fi
   if [ -d "Release-linux-en" ]; then
      printf "${COLOR}*${NOCOLOR} Deleting Release-linux-en directory\n"
      rm -Rf Release-linux-en
   fi
   if [ -d "Release-linux-es" ]; then
      printf "${COLOR}*${NOCOLOR} Deleting Release-linux-es directory\n"
      rm -Rf Release-linux-es
   fi
   
   printf "${COLOR}*${NOCOLOR} Prepare files for Release\n"
   mkdir Release-linux

   mv build/newIDE/ngpaws Release-linux/ngpaws
   mv $(find -iname ngpc -type d -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f 2) Release-linux/ngpc
   cp txtpaws/src/txtpaws Release-linux/txtpaws
   cp -R jsl example-code extra_langs installation_aux_files/* plugins Release-linux/
   
   cp -R Release-linux Release-linux-es
   mv Release-linux Release-linux-en
   
   printf "${COLOR}*${NOCOLOR} Setting Spanish database as default for Release-linux-es"
   mv Release-linux-es/database.start.spanish Release-linux-es/database.start
   
   printf "${COLOR}*${NOCOLOR} Setting English database as default for Release-linux-en"
   mv Release-linux-en/database.start.english Release-linux-en/database.start

   printf "${COLOR}*${NOCOLOR} Cleaning build folders\n\n"
   if [ -d "txtpaws" ]; then
      rm -Rf txtpaws   
   fi 

   if [ -d "build" ]; then
      rm -Rf build
   fi 
   
   printf "${COLOR}* English release is in Release-linux-en folder\n"
   printf "${COLOR}* Spanish release is in Release-linux-es folder\n"

   printf "\n${COLOR}--------------------\nDone\n--------------------${NOCOLOR}\n\n";
fi