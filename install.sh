#/bin/bash

GIT_DIR=~/dev/dotfiles # Where you keep the git repo
INSTALL_DIR=~/ # Where you want to install links

printf "==================================================\n"
printf "=YOU ARE ABOUT TO ANNIHILATE YOUR CURRENT FILES.==\n"
printf "======DID YOU MAKE A BACKUP OF EVERYTHING?========\n"
printf "==================================================\n"
printf "This script assumes that this script is being run=\n"
printf "from a local folder ~/dev/dotfiles. You should====\n"
printf "probably read through the script before running.==\n"
printf "==================================================\n"

install(){
  # I'm really not sure why this .vim links to itself in the
  # git repo here, but I guess I'll remove it right after...
  link_in .vim
  rm .vim/.vim # Hack work-around... Should fix this...
  link_in .tmux.conf
  link_in .vimrc
  link_in .zshoptions
  link_in .gitoptions
  # It would be nice to have this automatically add in the includes
  # but I don't have time to work through this right now.
  # append_sources "if [ -f $INSTALL_DIR/.zshoptions ]; \
  #                   then source $INSTALL_DIR/.zshoptions" ~/testing.txt
  create_default .zshrc
}

link_in(){
  # This uses a forced link; it'll overwrite whatever's there.
  # Remove the -f if you'd like a softer option. (Keep the -s though.)
  ln -fs "$GIT_DIR/$1" "$INSTALL_DIR/$1"
  printf "."
}

# Creates a default file if it doesn't exist
# Arguments: [file to be created]
create_default(){
  # make the file if it doesn't exist yet
  if [ ! -f $INSTALL_DIR/$1 ]; then
    cp $1 $INSTALL_DIR/$1;
  fi
  printf "."
}

# Appends the proper include lines to the dotfile provided.
# Arguments: [string to be appended], [dotfile]
# append_sources(){
#   # make the file if it doesn't exist yet
#   if [ ! -f $2 ]; then
#     touch $INSTALL_DIR/$2;
#   fi
# 
#   # add in the source if it's not already in the file
#   if [ ! "$(grep -Fxq $1 $INSTALL_DIR/$2)" ]; then
#     printf "$1\n" >> $INSTALL_DIR/$2
#   fi
#   printf "."
# }

main(){
  while true; do
      read -p "Are you sure you want to continue? (yes/no)" yn
      printf "\n"
      case $yn in
          [Yy]* ) install; exit;;
          [Nn]* ) printf "ABORT: no changes made\n"; exit;;
          * ) printf "Please answer yes or no.\n";;
      esac
  done
}

main;




