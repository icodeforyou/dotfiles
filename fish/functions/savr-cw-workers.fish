# Defined via `source`
function savr-cw-workers --wraps='cw tail -tl Worker-production:savr-worker -b1d' --description 'alias savr-cw-workers cw tail -tl Worker-production:savr-worker -b1d'
  cw tail -tl Worker-production:savr-worker -b1d $argv; 
end
