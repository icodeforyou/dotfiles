function insomnia --wraps='flatpak run rest.insomnia.Insomnia' --description 'alias insomnia=flatpak run rest.insomnia.Insomnia'
  flatpak run rest.insomnia.Insomnia $argv; 
end
