# PixelTool

Pixel-art workflow toolkit for [Aseprite](https://www.aseprite.org/) — timeline
selection helpers, frame export and palette utilities.

> **Status:** `0.1.0`, early scaffold. The selection and palette logic is in
> place; the export dialog wiring is still stubbed out (see `TODO` markers in
> `src/export.lua` and `src/util.lua`).

## Features

| Command | Description |
| --- | --- |
| `PixelTool: Export Selected Frames...` | Summarises the frames selected in the timeline |
| `PixelTool: Dump Palette to JSON...` | Writes the active sprite's palette to `palette.json` |

## Installation

1. Clone or download this repository.
2. Drop the whole folder into the Aseprite extensions directory:

   | Platform | Path |
   | --- | --- |
   | Windows | `%APPDATA%\Aseprite\extensions\` |
   | macOS | `~/Library/Application Support/Aseprite/extensions/` |
   | Linux | `~/.config/aseprite/extensions/` |

3. Restart Aseprite and confirm the extension is listed under
   **Edit → Preferences → Extensions**.

To build an installable bundle instead, zip the folder contents and rename the
archive to `PixelTool.aseprite-extension`, then double-click it.

## Usage

Once enabled, both commands appear in the command list. Open a sprite, select a
frame range in the timeline, then run:

```
PixelTool: Export Selected Frames...
```

## Project layout

```
.
├── package.json        # Aseprite extension manifest (name, version, commands)
├── main.lua            # Entry point — Aseprite calls init() / exit()
└── src/
    ├── export.lua      # Timeline selection and frame export
    ├── palette.lua     # Palette reading and JSON serialisation
    └── util.lua        # Shared helpers (alerts, paths, formatting)
```

## Development

Aseprite evaluates `main.lua` when the extension is enabled. After editing any
Lua file, disable and re-enable the extension (or restart Aseprite) to pick up
the changes — there is no hot reload.

`print()` output from `init()` lands in the Aseprite console, which is the
quickest way to confirm the extension actually loaded.

## License

Released under the [MIT License](LICENSE).
