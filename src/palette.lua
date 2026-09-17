-- Palette utilities.
--
-- Serialises the active sprite's palette so it can be diffed or fed into
-- other tools. Aseprite stores colours as 0-255 integers per channel.

local util = require("src.util")

local palette = {}

--- Reads every entry of the active sprite's first palette.
-- @return table|nil  array of { index, r, g, b, a }, or nil when there is no
--                    active sprite
function palette.collect()
  local sprite = app.sprite
  if not sprite then
    return nil
  end

  local pal = sprite.palettes[1]
  if not pal then
    return nil
  end

  local entries = {}
  for i = 0, #pal - 1 do
    local c = pal:getColor(i)
    entries[#entries + 1] = {
      index = i,
      r = c.red,
      g = c.green,
      b = c.blue,
      a = c.alpha,
    }
  end
  return entries
end

--- Renders the active palette as a JSON string.
-- @return string|nil
function palette.toJson()
  local entries = palette.collect()
  if not entries then
    return nil
  end

  local lines = {}
  for _, e in ipairs(entries) do
    lines[#lines + 1] = string.format(
      '    { "index": %d, "r": %3d, "g": %3d, "b": %3d, "a": %3d }',
      e.index, e.r, e.g, e.b, e.a
    )
  end

  return "[\n" .. table.concat(lines, ",\n") .. "\n]\n"
end

--- Prompts for a destination and writes the active palette there.
function palette.writeActivePalette()
  local json = palette.toJson()
  if not json then
    util.alert("No active sprite, or the sprite has no palette.")
    return
  end

  local path = util.askSavePath("palette.json")
  if not path then
    return
  end

  local f, err = io.open(path, "w")
  if not f then
    util.alert("Could not open " .. path .. " for writing:\n" .. tostring(err))
    return
  end

  f:write(json)
  f:close()

  util.alert(string.format("Wrote %d palette entries to\n%s", #palette.collect(), path))
end

return palette
