# nvim-typing-speed

A simple Neovim plugin to track and display your typing speed in words per minute (WPM). This plugin monitors the number of characters you type in real-time and calculates your typing speed.

## Features

- **Track Typing Speed**: Calculates and shows your typing speed in WPM.
- **Real-time Updates**: Typing speed is updated every minute based on your typing activity.
- **Simple Setup**: Easy to integrate into your Neovim setup with minimal configuration.

## Installation

### Using `lazy.nvim`

If you're using `lazy.nvim` for plugin management, add the following to your `init.lua`:

```lua
require('lazy').setup({
  'your-github-username/nvim-typing-speed', -- Replace with your repository path
})
