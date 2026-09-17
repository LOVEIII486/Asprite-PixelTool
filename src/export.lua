-- Frame export helpers.

local util = require("src.util")

local export = {}

--- Walks the timeline selection and returns the covered frame numbers.
--
-- Aseprite reports a selection as one or more ranges, each carrying a start
-- and end frame. A sprite with nothing selected has an empty selection table.
--
-- @param sprite Sprite
-- @return table  sorted array of 1-based frame numbers
function export.selectedFrameNumbers(sprite)
  local numbers = {}
  if not sprite or not sprite.selection then
    return numbers
  end

  local seen = {}
  for _, range in ipairs(sprite.selection) do
    local from = range.fromFrame.frameNumber
    local to = range.toFrame.frameNumber
    for f = from, to do
      if not seen[f] then
        seen[f] = true
        numbers[#numbers + 1] = f
      end
    end
  end

  table.sort(numbers)
  return numbers
end

--- Summarises the current selection.
-- @return string|nil
function export.describeSelection()
  local sprite = app.activeSprite
  if not sprite then
    return nil
  end

  local frames = export.selectedFrameNumbers(sprite)
  if #frames == 0 then
    return string.format(
      "Sprite \"%s\" has %d frame(s); nothing selected in the timeline.",
      sprite.filename or "untitled", #sprite.frames
    )
  end

  local labels = {}
  for _, n in ipairs(frames) do
    labels[#labels + 1] = util.frameLabel(n)
  end

  return string.format(
    "%d of %d frame(s) selected: %s",
    #frames, #sprite.frames, table.concat(labels, ", ")
  )
end

--- Entry point behind the "Export Selected Frames..." command.
--
-- TODO: the actual PNG writing still needs the export dialog wiring; for now
-- this reports what would be exported so the selection logic can be exercised.
function export.exportSelection()
  local summary = export.describeSelection()
  if not summary then
    util.alert("No active sprite.")
    return
  end

  util.alert(summary)
end

return export
