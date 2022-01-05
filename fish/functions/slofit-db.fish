# Defined via `source`
function slofit-db --wraps='mycli --ssh-user johan --ssh-host nuc.oktorp.se -u web-user -p blistark2020 sloingefitness' --description 'alias slofit-db mycli --ssh-user johan --ssh-host nuc.oktorp.se -u web-user -p blistark2020 sloingefitness'
  mycli --ssh-user johan --ssh-host nuc.oktorp.se -u web-user -p blistark2020 sloingefitness $argv; 
end
