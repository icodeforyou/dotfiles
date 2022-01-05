# Defined via `source`
function nuc --wraps='ssh johan@nuc.oktorp.se' --description 'alias nuc ssh johan@nuc.oktorp.se'
  ssh johan@nuc.oktorp.se $argv; 
end
