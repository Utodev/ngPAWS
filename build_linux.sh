#!/bin/bash

#Accept parameter -es for Spanish build, English otherwise

COLOR='\033[0;36m'
NOCOLOR='\033[0m'


echo "\n\n${COLOR}--------------------\nngPAWS linux builder\n--------------------${NOCOLOR}";
echo "${COLOR}*${NOCOLOR} You need Lazarus, git, and gcc installed on your system\n\n";
if [ $(which lazbuild) = "" ]; then
   echo "lazbuild coudn't be found. Please install it"
else
   #Start the build
   
   #build ngPAWS
   if [ -d "build" ]; then 
      echo "${COLOR}*${NOCOLOR} Deleting build directory\n"
      rm -Rf build
   fi
   
   echo "${COLOR}*${NOCOLOR} Building IDE\n"
   mkdir build
   cp -R newIDE build/newIDE
   lazbuild build/newIDE/ngpaws_linux.lpi

   echo "\n${COLOR}*${NOCOLOR} Building npgc compiler\n"
   cp -R compiler build/compiler/
   make -C build/compiler/

   #build txtpaws
   if [ -d "txtpaws" ]; then
      echo "\n${COLOR}*${NOCOLOR} txtpaws project directory exists\n"
   else
      echo "\n${COLOR}*${NOCOLOR} Cloning txtpaws\n"
      git clone https://github.com/Baltasarq/txtpaws/
   fi
   
   make -C txtpaws/src/ clean
   make -C txtpaws/src/ txtpaws
   
   #prepare the dist files
   if [ -d "dist" ]; then
      echo "\n${COLOR}*${NOCOLOR} Deleting dist directory\n"
      rm -Rf dist
   fi
   if [ -d "dist-en" ]; then
      echo "${COLOR}*${NOCOLOR} Deleting dist-en directory\n"
      rm -Rf dist-en
   fi
   if [ -d "dist-es" ]; then
      echo "${COLOR}*${NOCOLOR} Deleting dist-es directory\n"
      rm -Rf dist-es
   fi
   
   echo "${COLOR}*${NOCOLOR} Prepare files for distribution\n"
   mkdir dist

   mv build/newIDE/ngpaws dist/ngpaws
   mv build/compiler/ngpc dist/ngpc
   cp txtpaws/src/txtpaws dist/txtpaws
   cp -R jsl example-code extra_langs installation_aux_files/* plugins dist/
   
   cp -R dist dist-es
   mv dist dist-en
   
   echo "${COLOR}*${NOCOLOR} Setting Spanish databse as default for dist-es"
   mv dist-es/database.start.spanish dist-es/database.start
   
   echo "${COLOR}*${NOCOLOR} Setting English databse as default for dit-en"
   mv dist-en/database.start.english dist-en/database.start
   
   echo "\n${COLOR}--------------------\nDone\n--------------------${NOCOLOR}";
fi
