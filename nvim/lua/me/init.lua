local vim = vim
local fn = vim.fn
local cmd = vim.cmd
local check_file_path = fn.stdpath('config') .. '/lua/me/init_check'
-- Check if the file exists
--
vim.defer_fn(function()
    if fn.filereadable(check_file_path) == 0 then
        print("First time startup detected. Running initial scripts. You may be prompted to press 'y' to install some things.")
        -- Run the command
        cmd(':PackerSync')
        cmd(':TSInstall tsx java python lua')
        cmd(':COQdeps')
        cmd(':CHADdeps')
        print("We're all done here. Go ahead and reboot neovim!")
        -- Create the file
        local file = io.open(check_file_path, 'w')
        file:write('AUTOMATICALLY GENERATED')
        file:write('This is a check file to ensure the first-time script only runs once.')
        file:close()
    end
end, 0)
