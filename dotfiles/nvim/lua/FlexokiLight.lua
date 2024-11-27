-- FlexokiLight.lua

local colors = {
    fg = "#100F0F",
    bg = "#FFFCF0",
    sel_fg = "#100F0F",
    sel_bg = "#CECDC3",
    cursor = "#100F0F",
    cursor_text = "#FFFCF0",
    active_border = "#D14D41",
    inactive_border = "#CECDC3",
    active_tab_fg = "#100F0F",
    active_tab_bg = "#CECDC3",
    inactive_tab_fg = "#6F6E69",
    inactive_tab_bg = "#E6E4D9",
    black = "#100F0F",
    bright_black = "#6F6E69",
    red = "#D14D41",
    bright_red = "#AF3029",
    green = "#879A39",
    bright_green = "#66800B",
    yellow = "#D0A215",
    bright_yellow = "#AD8301",
    blue = "#4385BE",
    bright_blue = "#205EA6",
    magenta = "#CE5D97",
    bright_magenta = "#A02F6F",
    cyan = "#3AA99F",
    bright_cyan = "#24837B",
    white = "#FFFCF0",
    bright_white = "#F2F0E5"
}

local function apply_theme()
    -- Editor colors
    vim.cmd("hi Normal guifg=" .. colors.fg .. " guibg=" .. colors.bg)
    vim.cmd("hi Visual guifg=" .. colors.sel_fg .. " guibg=" .. colors.sel_bg)
    vim.cmd("hi Cursor guifg=" .. colors.cursor_text .. " guibg=" .. colors.cursor)
    vim.cmd("hi TabLineFill guifg=" .. colors.inactive_tab_fg .. " guibg=" .. colors.inactive_tab_bg)
    vim.cmd("hi TabLineSel guifg=" .. colors.active_tab_fg .. " guibg=" .. colors.active_tab_bg)

    -- Syntax highlighting
    vim.cmd("hi Comment guifg=" .. colors.bright_black)
    vim.cmd("hi String guifg=" .. colors.green)
    vim.cmd("hi Identifier guifg=" .. colors.blue)
    vim.cmd("hi Keyword guifg=" .. colors.red)
    vim.cmd("hi Function guifg=" .. colors.cyan)

    -- UI elements
    vim.cmd("hi StatusLine guifg=" .. colors.bg .. " guibg=" .. colors.fg)
    vim.cmd("hi VertSplit guifg=" .. colors.inactive_border)
    vim.cmd("hi LineNr guifg=" .. colors.bright_black)
end

apply_theme()
