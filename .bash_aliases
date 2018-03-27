# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias be='bundle exec'

alias git_log='git log --pretty=oneline --abbrev-commit --decorate --graph'

alias tree="tree -I 'node_modules|_build'"
alias tailf="tail -f"

# Shows all the commits that are on the current branch but not on the master.
# You can pass in other branch, i.e. develop.
#
# Examples
#
#     # show commits current branch vs master
#     $> ex_commits
#
#     # show commits current branch vs develop
#     $> ex_commits develop
#
function ex_commits () {
  REF="$(git symbolic-ref -q HEAD)"

  if [ -z "$1" ]
  then
    BRANCH="master"
  else
    BRANCH="$1"
  fi

  git log $REF --not $BRANCH --pretty=oneline --abbrev-commit --decorate
}

# Interactive squash of current commits, ass in branch if it's different
# than master i.e.
#
#     $> sq_exclusive develop
function sq_exclusive () {
  COMMITS="$(ex_commits $1 | wc -l)"

  git rebase -i HEAD~$COMMITS
}

alias gsuon='xhost si:localuser:root'

alias gsuoff='xhost -si:localuser:root'

