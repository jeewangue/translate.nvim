local M = {}

function M.cmd(text, _)
   text = text:gsub("[\r\n]", "")
   return text
end

return M
