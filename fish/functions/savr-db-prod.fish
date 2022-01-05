# Defined via `source`
function savr-db-prod --wraps='mycli --ssh-user j_thorstedt --ssh-host shell.savr.com -h savr-aurora-prod.cluster-ciy8vg4mxsne.eu-west-1.rds.amazonaws.com -u savr-user' --description 'alias savr-db-prod mycli --ssh-user j_thorstedt --ssh-host shell.savr.com -h savr-aurora-prod.cluster-ciy8vg4mxsne.eu-west-1.rds.amazonaws.com -u savr-user'
  mycli --ssh-user j_thorstedt --ssh-host shell.savr.com -h savr-aurora-prod.cluster-ciy8vg4mxsne.eu-west-1.rds.amazonaws.com -u savr-user $argv; 
end
