local nest = require('nest')
nest.applyKeymaps {
    -- Remove silent from ; : mapping, so that : shows up in command mode
    { ';', ':' , options = { silent = false } },

    {mode = 'n', {
        {'<LeftMouse>', '<LeftMouse>i'},
        -- leader
        {'<leader>', {
            {'sh', '<CMD>belowright 15split term://zsh<CR>' },
            {'rr', '<CMD>source $MYVIMRC<CR>' },

            -- leader f
            {'f', {
                {'f', '<CMD>FZF<CR>' },
                {'h', '<cmd>Telescope help_tags<CR>' }, 
                {'c', '<cmd>Telescope commands<CR> ' },
                {'b', '<cmd>Telescope buffers<CR>' },
                {'s', '<cmd>PRg<CR>' },
            }},
            {'wp', '<cmd>Files ~/vimwiki/<CR>' },
            {'sf', '<cmd>Telescope live_grep<CR>' },
            {'t', '<CMD>NERDTreeToggle<CR>'},
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
