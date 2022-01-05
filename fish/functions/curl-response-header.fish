# Defined via `source`
function curl-response-header --wraps='curl -s -D - -o /dev/null ' --wraps='curl -s -D - -o /dev/null' --description 'alias curl-response-header=curl -s -D - -o /dev/null'
  curl -s -D - -o /dev/null $argv; 
end
