local M = {}

---@param url string
---@param lines string[]
---@param command_args table
---@return string
---@return string[]
function M._cmd(url, lines, command_args)
  if not vim.g.deepl_api_auth_key then
    error("[translate.nvim] Set your DeepL API authorization key to g:deepl_api_auth_key.")
  end

  local cmd = "curl"
  local args = {
    "-X",
    "POST",
    "-s",
    url,
    "-d",
    "auth_key=" .. vim.g.deepl_api_auth_key,
    "-d",
    "target_lang=" .. command_args.target,
  }

  for _, t in ipairs(lines) do
    table.insert(args, "-d")
    table.insert(args, "text=" .. t)
  end

  if command_args.source then
    table.insert(args, "-d")
    table.insert(args, "source_lang" .. command_args.source)
  end

  return cmd, args
end

function M.complete_list(is_target)
  -- See <https://www.deepl.com/docs-api/translating-text/>, <https://developers.deepl.com/docs/resources/supported-languages>
  if is_target then
    -- Translation target languages based on DeepL API docs
    return {
      "AR",
      "BG",
      "CS",
      "DA",
      "DE",
      "EL",
      "EN-GB", -- English (British)
      "EN-US", -- English (American)
      "ES",
      "ET",
      "FI",
      "FR",
      "HU",
      "ID",
      "IT",
      "JA",
      "KO",
      "LT",
      "LV",
      "NB", -- Norwegian Bokmål
      "NL",
      "PL",
      "PT-BR", -- Portuguese (Brazilian)
      "PT-PT", -- Portuguese (excluding Brazilian)
      "RO",
      "RU",
      "SK",
      "SL",
      "SV",
      "TR",
      "UK",
      "ZH-HANS", -- Chinese (simplified)
      "ZH-HANT", -- Chinese (traditional)
    }
  else
    -- Translation source languages based on DeepL API docs
    return {
      "AR",
      "BG",
      "CS",
      "DA",
      "DE",
      "EL",
      "EN",
      "ES",
      "ET",
      "FI",
      "FR",
      "HU",
      "ID",
      "IT",
      "JA",
      "KO",
      "LT",
      "LV",
      "NB", -- Norwegian Bokmål
      "NL",
      "PL",
      "PT",
      "RO",
      "RU",
      "SK",
      "SL",
      "SV",
      "TR",
      "UK",
      "ZH",
    }
  end
end

return M
