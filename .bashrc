#[[ $- == *i* ]] || return
if [[ -r ~/.bashrc_local ]]; then
    . ~/.bashrc_local
fi
export CCACHE_DIR=/local2/mnt/workspace/ccache_dir  
export PATH=$PATH:/bin:/usr/local/sbin:/usr/sbin:/sbin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export GREP_OPTIONS='--color=auto'
export CATALINA_HOME=/usr/share/tomcat7/
export OPENGROK_TOMCAT_BASE=$CATALINA_HOME
export OPENGROK_INSTANCE_BASE=/local/mnt/workspace/qnx/grok_depot
export P4DIFF=/usr/bin/bcompare 
export P4MERGE="/usr/bin/bcompare $2 $3 $1 $4"
#-----------------
#aliases
#-----------------
# General aliases
alias now='date +%d_%b_%Y_%H_%M_%S'
alias cp='cp -v'
alias chmod='chmod -c'

alias lc='ls --color=auto'           
alias ll='ls -l'
#alias cmthis='make clean; make install'

alias cmthise='make clean;CCFLAGS+=-Wall CCFLAGS+=-Wextra CCFLAGS+=-Wno-unused-parameter CCFLAGS+=-Wno-unused-but-set-variable CCFLAGS+=-Wno-unused-but-set-variable CCFLAGS+=-Werror make install '
alias cmthisw='make clean;CCFLAGS+=-Werror make install '
alias gitignore='git update-index --skip-worktree'
alias lss='selectdirectory'
alias git_clean='ls -1 | grep -v .git  | xargs rm -rf gvim'
alias ag='ag --path-to-agignore ~/.agignore'
#Source qc specific bashfile
if [ -f ~/.bashrc_functions ]
then
    echo "~/.bashrc_functions exists. Sourcing it."
    source ~/.bashrc_functions
else
    echo "~/.bashrc_functions does not exists. Please ask owner for its location."
fi
if [ "$VIM" ] 
then 
    # For gvim's monochromatic :shell 
    PS1='\n\u@\h \w\n\$ ' 
    #unalias ls 
    #unalias grep
    :
fi 
#Source qc specific bashfile
if [ -f ~/.bashrc_qc ]
then
    echo "~/.bashrc_qc exists. Sourcing it."
    source ~/.bashrc_qc
else
    echo "~/.bashrc_qc does not exists. Please ask owner for its location."
fi

PROMPT_COMMAND='
  myhost=$(hostname)
  if [[ $myhost == aneeketp2-linux ]]; then
    myhost=${myhost^^}
    prompt_color=97
  else
    prompt_color=34
  fi
'

PS1='\[\e[$prompt_color;7m\][\u@$myhost \T \w>\[\e[0m\]'
#PS1='\u@$myhost \T \w>'
export PATH="/usr2/aneeketp/.linuxbrew/bin:$PATH"
export MANPATH="/usr2/aneeketp/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/usr2/aneeketp/.linuxbrew/share/info:$INFOPATH"
export HOMEBREW_CACHE="/usr2/aneeketp/.linuxbrew/cache"
