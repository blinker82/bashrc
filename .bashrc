export CCACHE_DIR=/local2/mnt/workspace/ccache_dir  
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
alias cmthis='make clean; make install'


# gvim
function gvim_init_remote()
{
    gvim  --servername $1
}

function gvim_open_remote()
{
    gvim  --servername $1 --remote-tab-silent $2
}

function gvimr_GVIM_func()
{
   gvim_open_remote GVIM $1
}

#plugin aliases
alias gvimr_init='gvim_init_remote GVIM'
alias gvimr='gvim_open_remote GVIM'
alias gvimr_init1='gvim_init_remote GVIM1'
alias gvimr1='gvim_open_remote GVIM1'
alias tag='echo "starting ctags ...";/usr/bin/ctags -R * ;echo "ctags done";echo "starting gtags ...";gtags;echo "gtags done"'
alias intag='find * -type d -exec /local/mnt/workspace/qnx/scripts/dirtags.sh {} \;'
#bash function aliases
alias oft='openfile "gvimr_GVIM_func"' 
alias of='openfile vim'
alias ofr='openfile_gvimr'
alias ofg='openfile_godir'
alias fif='findinfile "-i -n"'
alias fifg='findinfile'
alias fifw='findinfile "-i -n -w"'
alias fifbase='findinfilebase'
alias archivenow='create_archive_tar_gz'

#GIT
alias git_oneline='git log --pretty=oneline --decorate'
alias git_pretty='git log --pretty=format:'"'"'%C(yellow)%h%Cred%d%Creset - %C(cyan)%an %Creset: %s %Cgreen(%cr)'"'"
alias git_graph='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"'
alias git_diff='git difftool --tool="bc3"'
#P4 Alias
alias p4init='export P4CONFIG=.p4config'


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
    echo "openfile '$'"
    PS3="Type a number or 'q' to quit:"
    fileList=$(find . -type f -iname '*'$2'*')
    txtblue
    select fileName in $fileList; do
        if [ -n "$fileName" ]; 
        then
            if [ -z "$3" ]; then
                $1 ${fileName}
            else 
                $1 +$3 ${fileName}
            fi
        fi
        break
    done
    txtrst
}


function openfile_gvimr()
{
    PS3="Type a number or 'q' to quit:"
    fileList=$(find . -type f -iname '*'$*'*')
    txtblue
    select fileName in $fileList; do
        if [ -n "$fileName" ]; then
            gvimr ${fileName}
        fi
        break
    done
    txtrst
}
#goto directory of this file
function gofile()
{
    PS3="Type a number or 'q' to quit:"
    txtbld
    txtund
    fileList=$(find . -type f -iname '*'$*'*')
    txtrst
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
    txtbld
    txtund
    echo "find . -type d -iname '*'$*'*'"
    txtrst
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


# find this text in the file
function findinfile()
{
    txtbld
    txtund
    txtred
    echo  "find . -type f -iname '*'$2'*' -print | xargs grep $1 $3"
    txtrst
    txtblue
    find . -type f -iname '*'$2'*' -print | xargs grep $1 $3
    txtrst
    txtred
    echo "RESULTS END"
    txtrst
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
