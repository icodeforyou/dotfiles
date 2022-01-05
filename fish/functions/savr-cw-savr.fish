# Defined via `source`
function savr-cw-savr --wraps='cw tail -tl SAVR-production:savr.com -b1d' --description 'alias savr-cw-savr cw tail -tl SAVR-production:savr.com -b1d'
  cw tail -tl SAVR-production:savr.com -b1d $argv; 
end
