-- Shared helpers used across PixelTool modules.

local util = {}

--- Shows a modal alert prefixed with the extension name.
-- @param text string
function util.alert(text)
  app.alert{ title = "PixelTool", text = text }
end

--- Resolves a destination path for a generated file.
--
-- TODO: this currently drops the file straight into the user's Documents
-- folder. The proper version should prompt, which means building a `Dialog`
-- and adding a `file` field to it — `app.fs` on its own only resolves paths,
-- it has no picker.
--
-- @param suggestedName string
-- @return string|nil
function util.askSavePath(suggestedName)
  local dir = app.fs.userDocsPath
  if not dir then
    util.alert("Could not resolve the user documents folder.")
    return nil
  end
  return app.fs.joinPath(dir, suggestedName)
end

--- Formats a frame number the way the timeline displays it.
-- @param n integer
-- @return string
function util.frameLabel(n)
  return string.format("#%d", n)
end

return util
