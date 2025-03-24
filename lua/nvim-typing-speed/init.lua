-- nvim-typing-speed/init.lua

local M = {}

-- typing data
local start_time = nil
local char_count = 0
local typing_speed = 0
local typing_timer = nil

local function update_typing_speed()
  local current_time = vim.fn.reltime()
  local elapsed_time = vim.fn.reltimefloat(current_time) - vim.fn.reltimefloat(start_time)
  -- caculate the word per min(WPM) 
  local words_per_minute = (char_count / 5) / (elapsed_time / 60)
  typing_speed = math.floor(words_per_minute)
  vim.notify(require('nvim-typing-speed').get_typing_speed())
end

function M.get_typing_speed()
    return string.format("Typing Speed: %d WPM", typing_speed)
end

function M.setup()
  vim.notify("setup")
end

function M.start_typing()
  vim.notify('start typing')
  start_time = vim.fn.reltime()
  char_count = 0
  typing_speed = 0
  -- set update timer
  if typing_timer then
    vim.fn.timer_stop(typing_timer)
  end
  typing_timer = vim.fn.timer_start(60000, function ()
    update_typing_speed()
  end, {['repeat'] = -1 })

  vim.cmd("augroup TypingSpeed")
  vim.cmd("autocmd!")
  vim.cmd("autocmd TextChangedI * lua require('nvim-typing-speed').on_text_changed()")
  vim.cmd("augroup END")
end

function M.on_text_changed()
    char_count = char_count + 1
end

function M.stop_typing()
    vim.cmd("autocmd! TextChanged")
    vim.notify('stop typing')
end

return M
