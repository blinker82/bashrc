export CCACHE_DIR=/local2/mnt/workspace/ccache_dir  
export PATH=$PATH:~/bin:/usr/local/sbin:/usr/sbin:/sbin
export GREP_OPTIONS='--color=auto'
export CATALINA_HOME=/usr/share/tomcat7/
export OPENGROK_TOMCAT_BASE=$CATALINA_HOME
export OPENGROK_INSTANCE_BASE=/local/mnt/workspace/qnx/grok_depot
export P4DIFF=/usr/bin/bcompare 
#-----------------
#aliases
#-----------------
# General aliases
alias now='date +%d_%b_%Y_%H_%M_%S'
alias cp='cp -v'
alias chmod='chmod -c'
alias txtbld='tput bold'  #bold
alias txtund='tput sgr 0 1' #underline
alias txtrst='tput sgr0' #Reset
alias txtred='tput setaf 1' #red
alias txtblue='tput setaf 4' #blue
alias lc='ls --color=auto'           
alias ll='ls -l'
alias cmthis='make clean; make install'
alias cmthisw='make clean; make install CCFLAGS=-Werror'
alias gitignore='git update-index --skip-worktree'
alias lss='selectdirectory'
alias git_clean='ls -1 | grep -v .git  | xargs rm -rf gvim'

#Source qc specific bashfile
if [ -f ~/.bashrc_functions ]
then
    echo "~/.bashrc_functions exists. Sourcing it."
    source ~/.bashrc_functions
else
    echo "~/.bashrc_functions does not exists. Please ask owner for its location."
fi

#Source qc specific bashfile
if [ -f ~/.bashrc_qc ]
then
    echo "~/.bashrc_qc exists. Sourcing it."
    source ~/.bashrc_qc
else
    echo "~/.bashrc_qc does not exists. Please ask owner for its location."
fi

