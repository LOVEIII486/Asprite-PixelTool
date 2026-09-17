-- Frame export helpers.

local util = require("src.util")

local export = {}

--- Normalises one entry of `app.range.frames` to a frame number.
--
-- The API reference shows the *setter* taking plain numbers
-- (`app.range.frames = { 1, 2, ... }`) but describes the getter only as "the
-- array of selected frames", linking to the Frame class. Which of the two a
-- read actually yields is not stated, so handle both.
--
-- @param entry number|Frame
-- @return number|nil
local function frameNumberOf(entry)
  if type(entry) == "number" then
    return entry
  end
  return entry and entry.frameNumber
end

--- Returns the frame numbers currently selected in the timeline.
--
-- `app.range` is the timeline selection — distinct from `sprite.selection`,
-- which tracks the selected *pixels* on the canvas. `isEmpty` is true when
-- nothing is selected in the timeline.
--
-- @return table  sorted, de-duplicated array of frame numbers
function export.selectedFrameNumbers()
  local range = app.range
  if not range or range.isEmpty then
    return {}
  end

  local numbers, seen = {}, {}
  for _, entry in ipairs(range.frames) do
    local n = frameNumberOf(entry)
    if n and not seen[n] then
      seen[n] = true
      numbers[#numbers + 1] = n
    end
  end

  table.sort(numbers)
  return numbers
end

--- Describes the current sprite and its timeline selection.
-- @return string|nil
function export.describeSelection()
  local sprite = app.sprite
  if not sprite then
    return nil
  end

  -- An unsaved sprite reports an empty filename rather than nil.
  local name = sprite.filename
  if not name or name == "" then
    name = "untitled"
  end

  local frames = export.selectedFrameNumbers()
  if #frames == 0 then
    return string.format(
      'Sprite "%s" has %d frame(s); nothing selected in the timeline.',
      name, #sprite.frames
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
