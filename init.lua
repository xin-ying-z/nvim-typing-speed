-- nvim-typing-speed/init.lua

local M = {}

-- typing data
local start_time = nil
local char_count = 0
local typing_speed = 0

local function update_typing_speed()
    local current_time = vim.fn.reltime(vim.fn.reltime(start_time))
    -- caculate the word per min(WPM) 
    local words_per_minute = (char_count / 5) / (current_time / 60)
    typing_speed = math.floor(words_per_minute)
    vim.opt.statusline('let &statusline="%{v:lua.require(\'typing-speed\').get_typing_speed()}"')
end

function M.get_typing_speed()
    return string.format("Typing Speed: %d WPM", typing_speed)
end

function M.start_typing()
    start_time = vim.fn.reltime()
    char_count = 0
    typing_speed = 0
    vim.cmd("augroup TypingSpeed")
    vim.cmd("autocmd!")
    vim.cmd("autocmd TextChanged * lua require('typing-speed').on_text_changed()")
    vim.cmd("augroup END")
end

function M.on_text_changed()
    char_count = char_count + 1
    update_typing_speed()
end

function M.stop_typing()
    vim.cmd("autocmd! TextChanged")  -- 取消监听文本变化
    vim.cmd("echo 'Typing speed tracking stopped'")
end

return M
