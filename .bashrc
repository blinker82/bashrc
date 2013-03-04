export PATH=$PATH:~/bin:/usr/local/sbin:/usr/sbin:/sbin
export GREP_OPTIONS='--color=auto'

#-----------------
#aliases
#-----------------

# General aliases
alias now='date +%d_%b_%Y_%H_%M'
alias cp='cp -v'
alias chmod='chmod -c'
alias txtbld='tput bold'  #bold
alias txtund='tput sgr 0 1' #underline
alias txtrst='tput sgr0' #Reset
alias txtred='tput setaf 1' #red
alias txtblue='tput setaf 4' #blue
alias ls='ls --color'           
alias ll='ls -l'

#plugin aliases
alias gvimr='gvim --servername GVIM --remote-tab'
alias tag='/usr/bin/ctags -R * &'

#bash function aliases
alias of='openfile'
alias ofb='openfilebase'
alias ofg='openfile_godir'
alias fif='findinfile'
alias fifbase='findinfilebase'
alias archivenow='create_archive_tar_gz'

#GIT
alias git_oneline='git log --pretty=oneline --decorate'
alias git_pretty='git log --pretty=format:'"'"'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"'"
alias git_graph='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"'

# Print the current Path
function print_curr_path_dir()
{
    local temp=$(pwd | grep -i $1)
    if [ -n "$temp" ]
    then
        pwd | sed -re 's/(^.*'$1')(.*)/\1/I'
    fi
}

#list files which contain the following name in current directory and sub
function ff() 
{ 
    txtbld
    txtund
    echo "find . -type f -iname '*'$*'*' -ls"
    txtrst
    txtblue
    find . -type f -iname '*'$*'*' -ls
    txtbld
    txtund
    echo "END RESULTS"
    txtrst
}

#list files which contain the following names in the whole build
function ffbase() 
{ 
    local currpath=$(pwd)
    echo "currpath is $currpath"
    gobase
    txtbld
    txtund
    echo "find . -type f -iname '*'$*'*' -ls"
    txtrst
    txtblue
    find . -type f -iname '*'$*'*' -ls
    txtbld
    txtund
    echo "END RESULTS"
    txtrst
    
    echo "currpath is $currpath"
    cd $currpath
}

#list folders which contain the following name in this directory and its sub
function ffr() 
{ 
    find . -type d -iname '*'$*'*' -ls ; 
}

#open file and also cd to that directory
function openfile_godir()
{
   PS3="Type a number or 'q' to quit:"
   fileList=$(find . -type f -iname '*'$*'*')
   txtblue
   select fileName in $fileList; do
        if [ -n "$fileName" ]; then
           local derivedpath=$(dirname ${fileName})
           local derived_file_name=$(basename ${fileName})
           cd $derivedpath
           vim $derived_file_name
        fi
        break
   done
   txtrst
}

#only open file and do not cd to that directory
function openfile()
{
   PS3="Type a number or 'q' to quit:"
   fileList=$(find . -type f -iname '*'$*'*')
   txtblue
   select fileName in $fileList; do
        if [ -n "$fileName" ]; then
           vim ${fileName}
        fi
        break
   done
   txtrst
}

#open file from the base of your build
function openfilebase()
{
   local currpath=$(pwd)
   gobase
   PS3="Type a number or 'q' to quit:"
   fileList=$(find . -type f -iname '*'$*'*')
   txtblue
   select fileName in $fileList; do
        if [ -n "$fileName" ]; then
           vim ${fileName}
        fi
        break
   done
   txtrst
   cd $currpath
}

#goto directory of this file
function gofile()
{
   PS3="Type a number or 'q' to quit:"
   fileList=$(find . -type f -iname '*'$*'*')
   txtblue
   select fileName in $fileList; do
        if [ -n "$fileName" ]; then
           local derivedpath=$(dirname ${fileName})
           cd $derivedpath
        fi
        break
   done
   txtrst
}

#goto this directory
function godir()
{
    PS3="Type a number or 'q' to quit:"
    echo "find . -type d -iname '*'$*'*'"
    folderList=$(find . -type d -iname '*'$*'*')
    txtblue
    select folderName in $folderList; do
        if [ -n "$folderName" ]; then
            cd ${folderName}
        fi
        break
    done
    txtrst
}

#goto this directory and search from base of build
function godirbase()
{
   local currpath=$(pwd)
   gobase
   PS3="Type a number or 'q' to quit:"
    folderList=$(find . -type d -iname '*'$*'*')
    select folderName in $folderList; do
        if [ -n "$folderName" ]; then
            cd ${folderName}
        fi
        break
    done
    cd $currpath
}

# find this text in the file
function findinfile()
{
 txtbld
 txtund
 txtred
 echo  "find . -type f -iname '*'$1'*' -print | xargs grep -i $2"
 txtrst
 txtblue
 find . -type f -iname '*'$1'*' -print | xargs grep -n -i $2
 txtrst
 txtred
 echo "RESULTS END"
 txtrst
}

# find this text in the file : search from base of build
function findinfilebase()
{
 local currpath=$(pwd)
 gobase
 txtbld
 txtund
 txtred
 echo  "find . -type f -iname '*'$1'*' -print | xargs grep -i $2"
 txtrst
 txtblue
 find . -type f -iname '*'$1'*' -print | xargs grep -n -i $2
 txtrst
 txtred
 echo "RESULTS END"
 txtrst
 cd $currpath
}

#dont know
function listinfile()
{
    
   PS3="Type a number or 'q' to quit:"
   echo "find . -type f -iname '*'$1'*' -print | xargs grep -i $2 "
   fileList=$(find . -type f -iname '*'$1'*' -print | xargs grep -i $2 )
   fileList_final=$($fileList | sed -re 's/(^.*':')(.*)/\1/I') 
   select fileName in $fileList_final; do     
        if [ -n "$fileName" ]; then
            vim ${fileName}
        fi
        break
   done
}

#Source qc specific bashfile
source ~/bashrc_qc/.bashrc_qc
