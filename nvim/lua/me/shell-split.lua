local shellsplit = {}
function shellsplit.newshell()
    local name=vim.api.nvim_buf_get_name(0)
    if string.find(name,"term://") then
        vim.api.nvim_command('q')
        return
    else
        vim.api.nvim_command('belowright 15split term://zsh')
        vim.api.nvim_command('hi ActiveWindow guibg=#17252c | setl winhighlight=Normal:ActiveWindow')
        vim.o.winfixwidth = true
        vim.o.winfixheight = true
        return
    end
end
return shellsplit
