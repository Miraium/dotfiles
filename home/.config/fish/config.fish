if type -q eza
    alias ei="eza --icons --git"
    alias ea="eza -a --icons --git"
    alias ee="eza -aahl --icons --git"
    alias et="eza -T -L 3 -a -I 'node_modules|.git|.cache' --icons"
    alias eta="eza -T -a -I 'node_modules|.git|.cache' --color=always --icons | less -r"
    alias ls=ei
    alias la=ea
    alias ll=ee
    alias lt=et
    alias lta=eta
    alias l="clear && ls"
end

set LS_COLORS "ow=01;36"

if type -q zoxide
    zoxide init fish | source
end

if type -q starship
    starship init fish | source
end
