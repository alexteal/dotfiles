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
    *"fc36"*)
        export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
        ;;
    *) 
        ;;
esac


alias sl="osascript -e 'tell application \"System Events\" to sleep'"
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
alias jdbg="javac -g *.java; java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y" #followed by filename
alias jtest="javac -g *.java; java" #followed by file name
alias todo='nvim ~/TODO -c ":set filetype=vimwiki"'
alias rmgui='python3 -m remy.gui'
alias l='ls -lah --color=auto'
alias ls='ls -GH --color=auto'
alias rsync='/usr/local/bin/rsync --ignore-existing -a --info=progress2 --stats'
alias graal="export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.1/Contents/Home/bin:$PATH ; export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.1/Contents/Home; echo 'java path set to graalvm'"
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
