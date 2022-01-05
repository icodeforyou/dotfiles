function git-changes --wraps='git log --pretty=oneline --format="%s" HEAD...master' --description 'alias git-changes=git log --pretty=oneline --format="%s" HEAD...master'
  git log --pretty=oneline --format="%s" HEAD...master $argv; 
end
