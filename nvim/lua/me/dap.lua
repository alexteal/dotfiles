--debugger setup, required for each language
local dap = require('dap')
dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
            return '/usr/bin/python'
        end;
    },
}
dap.configurations.java = {
    type = 'java';
    request = "launch";
    vmArgs = "-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=5005,suspend=y"
}
