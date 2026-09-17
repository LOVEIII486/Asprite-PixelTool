-- Shared helpers used across PixelTool modules.

local util = {}

--- Shows a modal alert prefixed with the extension name.
-- @param text string
function util.alert(text)
  app.alert{ title = "PixelTool", text = text }
end

--- Asks the user for a destination path.
--
-- TODO: swap the hard-coded temp location for a real save dialog once the
-- dialog bindings are settled — `app.fs` exposes file access but the picker
-- is only reachable through the app-level dialog API.
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
