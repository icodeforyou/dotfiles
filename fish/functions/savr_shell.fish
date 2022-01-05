# Defined via `source`
function savr_shell --wraps='ssh j_thorstedt@shell.savr.com' --description 'alias savr_shell ssh j_thorstedt@shell.savr.com'
  ssh j_thorstedt@shell.savr.com $argv; 
end
