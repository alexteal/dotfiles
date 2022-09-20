local nest = require('nest')
local shell = require('shell-split')
nest.applyKeymaps {
    -- Remove silent from ; : mapping, so that : shows up in command mode
    { ';', ':' , options = { silent = false } },

    {mode = 'n', {
        {'<LeftMouse>', '<LeftMouse>i'},
        -- leader
        {'<leader>', {
            -- rebind jumping back to previous buffer
            {'bb', '<c-6>'},
            -- quick open terminal
            {'sh', shell.newshell },
            -- quick resource
            {'rr', '<CMD>source $MYVIMRC<CR>' },
            -- quick edit 
            {'qe', '<CMD>tabnew ~/.config/nvim/init.lua | cd ~/.config/nvim<CR>'},

            -- leader f
            {'f', {
                {'f', '<CMD>FZF<CR>' },
                {'h', '<cmd>Telescope help_tags<CR>' }, 
                {'c', '<cmd>Telescope commands<CR> ' },
                {'b', '<cmd>Telescope buffers<CR>' },
                {'s', '<cmd>PRg<CR>' },
            }},
            {'wp', '<cmd>Files ~/vimwiki/<CR>' },
            -- search folder (uses pwd)
            {'sf', '<cmd>Telescope live_grep<CR>' },
            --search THIS folder ( uses current buffer directory )
            {'stf','<cmd>lua require"telescope.builtin".live_grep{ search_dirs={"%:p:h"} }<CR>'},
            {'t', '<CMD>NvimTreeToggle<CR>'},
            {'da', 'i<return><esc><up><cmd>put =strftime(\'%c\')<CR>i<backspace>==<Esc><S-a>==<esc><S-a><return>'},
            {'js', '<cmd>JsDoc<CR>'},
        }},
    }},
    {mode = 'i', {
        {'//', '<Esc>'},
        {'jj', '<Esc>'},
        {'\'', '\'\'<left>' },
        {'\"', '\"\"<left>' },
        {'(' , '()<left>' },
        {'[' , '[]<left>' },
        {'{' , '{}<left>' },
        {'{<CR>', '{<CR>}<ESC>O' },
        {'{;<CR>', '{<CR>};<ESC>O' },
    }},
    {mode = 't', {
        {'//', '<C-\\><C-n>' }, 
        {'jj', '<C-\\><C-n>' }, 
    }}, 
    {mode = 'v', {
        {'//', '<Esc>'},
    }},
}
