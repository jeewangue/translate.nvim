local api = vim.api
local fn = vim.fn

local M = {}
local L = {}

function M.get(args, is_visual)
    if is_visual then
        return L.get_visual_selected()
    else
        return L.get_current_line()
    end
end

function L.get_visual_selected()
    local mode = fn.visualmode()

    -- {bufnum, lnum, col, off}
    local tl = fn.getpos("'<")
    local br = fn.getpos("'>")

    local pos_s = { tl[2], tl[3] }
    local pos_e = { br[2], br[3] }

    local lines = api.nvim_buf_get_lines(0, pos_s[1] - 1, pos_e[1], true)

    local pos = {}
    pos._lines = lines
    pos._mode = mode

    if mode == "v" then
        for i, line in ipairs(lines) do
            local p = { row = pos_s[1] + i - 1, col = { 1, #line } }
            if i == 1 then
                p.col[1] = pos_s[2]
            end
            if i == #lines then
                p.col[2] = pos_e[2]
            end
            table.insert(pos, p)
        end
    elseif mode == "V" then
        for i, line in ipairs(lines) do
            table.insert(pos, { row = pos_s[1] + i - 1, col = { 1, #line } })
        end
    elseif mode == "" then
        for i, _ in ipairs(lines) do
            table.insert(pos, { row = pos_s[1] + i - 1, col = { pos_s[2], pos_e[2] } })
        end
    end

    return pos
end

function L.get_current_line()
    local line = api.nvim_get_current_line()
    local pos = { { row = row, col = { 1, #line } } }
    pos._lines = { line }
    pos._mode = "n"
    return pos
end

return M
