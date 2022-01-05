# Defined via `source`
function savr-cw-data-api --wraps='cw tail -tl Data-api-production:data-api.savr.nu -b1d' --description 'alias savr-cw-data-api cw tail -tl Data-api-production:data-api.savr.nu -b1d'
  cw tail -tl Data-api-production:data-api.savr.nu -b1d $argv; 
end
