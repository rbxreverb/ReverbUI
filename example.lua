debugX = true

local ReverbLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/source.lua'))()

local Window = ReverbLib:CreateWindow({
   Name = "ReverbLib Example Window",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Reverb",
   LoadingSubtitle = "Loading",
   Theme = "Default",

   DisableReverbLibPrompts = true,
   DisableBuildWarnings = false, -- Prevents ReverbLib from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   -- ReverbLib's built-in key system has been removed.
   -- Run your own loader/key checks before creating this window.
})

local Tab = Window:CreateTab("Tab Example", 4483362458) -- Title, Image

local Section = Tab:CreateSection("Section Example")

local Button = Tab:CreateButton({
   Name = "Button Example",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

ReverbLib:LoadConfiguration()
