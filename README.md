# ReverbUI

Personal Roblox UI library used as `ReverbLib`.

This project is based on [Rayfield](https://github.com/SiriusSoftwareLtd/Rayfield) by SiriusSoftwareLtd and keeps the same general API shape so existing Rayfield-style scripts are easy to adapt.

## Quick Start

Once this repo is on GitHub, load it like this:

```lua
local ReverbLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/source.lua"))()
```

Then use it the same way Rayfield is normally used:

```lua
local Window = ReverbLib:CreateWindow({
   Name = "Reverb Hub",
   LoadingTitle = "ReverbLib Interface Suite",
   LoadingSubtitle = "by Reverb",
   Theme = "Default",
   DisableReverbLibPrompts = true,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "ReverbHub"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Reverb Hub",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "ReverbKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Hello"}
   }
})

local MainTab = Window:CreateTab("Main", "house")

MainTab:CreateButton({
   Name = "Button Example",
   Callback = function()
      print("Clicked")
   end,
})

ReverbLib:LoadConfiguration()
```

## Public vs Private GitHub

For a normal `game:HttpGet("https://raw.githubusercontent.com/...")` loadstring, the repository needs to be public. Private GitHub raw links normally require authentication, and Roblox/executor `HttpGet` calls will not have your browser login.

The simple path is:

1. Create a public GitHub repo named `ReverbUI`.
2. Upload `source.lua`, `icons.lua`, `assets/`, `example.lua`, `Documentation.md`, `LICENSE`, and this readme.
3. Make sure the `rawBaseUrl` value near the top of `source.lua` points at this repo:

```lua
local rawBaseUrl = "https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/"
```

## ReverbLib Options

ReverbLib supports these globals before loading:

```lua
getgenv().REVERBLIB_RAW_BASE = "https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/"
getgenv().REVERBLIB_ASSET_ID = 1234567890
getgenv().REVERBLIB_SECURE = true
getgenv().DISABLE_REVERBLIB_REQUESTS = true
```

The old Rayfield globals are still accepted as fallbacks for compatibility.

## Current Rebrand Pass

- Public usage should refer to `ReverbLib`.
- The default theme uses Reverb cyan `#00e2f8` on a dark premium base.
- Config files save under `ReverbLib/Configurations` using `.rvbl`.
- Upstream analytics/reporting has been removed.
- The upstream Apache-2.0 license is preserved.

## Attribution

ReverbUI is based on Rayfield by SiriusSoftwareLtd. See `LICENSE` for the original Apache-2.0 license terms.
