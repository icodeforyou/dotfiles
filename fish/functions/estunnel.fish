# Defined via `source`
function estunnel --wraps='ssh estunnel -N' --description 'alias estunnel=ssh estunnel -N'
  ssh estunnel -N $argv; 
end
