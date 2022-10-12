OS=$( uname -a )
# unsure if first character is capital or not
case $OS in 
    *"ebian"*)
        ;;
    *"buntu"*)
        ;;
    *"arwin"*)
        export LS_COLORS=exfxcxdxbxegedabagacad
        export LSCOLORS=exfxcxdxbxegedabagacad
        ;;
    *"edora"*)
        ;;
    *"fc36"*) # testing this for now, not sure if it's a good solution.                                    │
                   # need better portable os type solution
        ;;
    *) 
        export LS_COLORS=exfxcxdxbxegedabagacad
        export LSCOLORS=exfxcxdxbxegedabagacad
        ;;
esac


#alias ls="ls -G"
alias snooze="osascript -e 'tell application \"System Events\" to sleep'"
#set LS colors
alias ls='ls -GH'
alias nq='networkquality'
alias rmpdf='rm2pdf -t ~/projects/remarkable/rm2pdf/templates/A4.pdf'
alias pomo-clear='rm ~/Library/Application\ Support/pomo/pomo.db; pomo init'
alias pdf2rm='~/bin/pdf2rmnotebook'
alias updf2rm='~/.scripts/updf2rm'
alias jcmp='javac -g *.java'
alias jarify='jar -cvf build.jar *' # doesn't work right. I think?
alias convert2pdf='/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf'
alias gradlew='./gradlew'
alias ss='source ~/.zshrc'
# quick edit config files
alias editnvim="nvim ~/.config/nvim/init.lua"
alias editzsh="nvim ~/.zshrc"
alias edittmux="nvim ~/.tmux.conf"
alias dot="cd ~/projects/dotfiles"
alias dotconf="cd ~/.config/nvim/"
alias lg="lazygit"
alias jdbg="java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y" #followed by filename
alias todo='nvim ~/TODO -c ":set filetype=vimwiki"'
alias regex='echo "
POSIX       REGEX           MEANING
################################################################################
[:upper:]	[A-Z]	        uppercase letters
[:lower:]	[a-z]	        lowercase letters
[:alpha:]	[A-Za-z]	upper- and lowercase letters
[:digit:]	[0-9]	        digits
[:xdigit:]	[0-9A-Fa-f]	hexadecimal digits
[:alnum:]	[A-Za-z0-9]	digits, upper- and lowercase letters
[:punct:]		        punctuation (all graphic characters except 
                                letters and digits)
[:blank:]	[ \\\t]	        space and TAB characters only
[:space:]	[\\\t\\\n\\\r\\\f\\\v]    blank (whitespace) characters
[:cntrl:]		        control characters
[:graph:]	[^ [:cntrl:]]	graphic characters (all characters which have 
                                graphic representation)
[:print:]	[[:graph:] ]	graphic characters and space
[:word:]	[[:alnum:]_]	Alphanumeric characters with underscore character _,
                                meaning alnum + _. It is a bash specific 
                                character class.
"
'
