-- PixelTool — Aseprite extension entry point.
--
-- Aseprite evaluates this script once when the extension is enabled
-- (Edit > Preferences > Extensions) and calls `init()`. `exit()` is called
-- when the extension is disabled, uninstalled, or Aseprite quits.

local palette = require("src.palette")
local exporter = require("src.export")

local VERSION = "0.1.0"

function init(plugin)
  plugin:newCommand{
    id = "PixelToolExportSelection",
    title = "PixelTool: Export Selected Frames...",
    group = "file_export",
    onclick = function()
      exporter.exportSelection()
    end
  }

  plugin:newCommand{
    id = "PixelToolDumpPalette",
    title = "PixelTool: Dump Palette to JSON...",
    group = "file_export",
    onclick = function()
      palette.writeActivePalette()
    end
  }

  print(string.format("PixelTool %s loaded", VERSION))
end

function exit(plugin)
  -- Commands registered in init() are torn down by Aseprite when the
  -- extension is disabled; nothing to release manually here yet.
end
