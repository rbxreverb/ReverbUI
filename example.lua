debugX = true

local ReverbLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/source.lua'))()

local Window = ReverbLib:CreateWindow({
   Name = "Reverb Hub",
   Icon = "radio",
   LoadingTitle = "Reverb",
   LoadingSubtitle = "Loading",
   Theme = "Default",

   DisableReverbLibPrompts = true,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "ReverbHubExample"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
})

local MainTab = Window:CreateTab("Main", "house")
local PlayerTab = Window:CreateTab("Player", "user")
local SettingsTab = Window:CreateTab("Settings", "settings")

MainTab:CreateSection("Actions")

MainTab:CreateButton({
   Name = "Send Notification",
   Callback = function()
      ReverbLib:Notify({
         Title = "Reverb",
         Content = "This is a ReverbLib notification.",
         Duration = 5,
         Image = "bell"
      })
   end,
})

MainTab:CreateToggle({
   Name = "Example Toggle",
   CurrentValue = false,
   Flag = "ExampleToggle",
   Callback = function(Value)
      print("Toggle:", Value)
   end,
})

MainTab:CreateDropdown({
   Name = "Example Dropdown",
   Options = {"Option One", "Option Two", "Option Three"},
   CurrentOption = {"Option One"},
   MultipleOptions = false,
   Flag = "ExampleDropdown",
   Callback = function(Options)
      print("Selected:", Options[1])
   end,
})

MainTab:CreateInput({
   Name = "Example Input",
   CurrentValue = "",
   PlaceholderText = "Type something...",
   RemoveTextAfterFocusLost = false,
   Flag = "ExampleInput",
   Callback = function(Text)
      print("Input:", Text)
   end,
})

PlayerTab:CreateSection("Player Controls")

PlayerTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 100},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      local character = game.Players.LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.WalkSpeed = Value
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 200},
   Increment = 5,
   Suffix = "power",
   CurrentValue = 50,
   Flag = "JumpPower",
   Callback = function(Value)
      local character = game.Players.LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.JumpPower = Value
      end
   end,
})

PlayerTab:CreateKeybind({
   Name = "Toggle Example Bind",
   CurrentKeybind = "Q",
   HoldToInteract = false,
   Flag = "ExampleKeybind",
   Callback = function()
      print("Keybind pressed")
   end,
})

SettingsTab:CreateSection("Appearance")

SettingsTab:CreateColorPicker({
   Name = "Accent Preview",
   Color = Color3.fromRGB(0, 226, 248),
   Flag = "AccentPreview",
   Callback = function(Color)
      print("Selected color:", Color)
   end,
})

SettingsTab:CreateDropdown({
   Name = "Theme",
   Options = {"Default", "Ocean", "AmberGlow", "Light", "Amethyst", "Green", "Bloom", "DarkBlue", "Serenity"},
   CurrentOption = {"Default"},
   MultipleOptions = false,
   Flag = "ThemeSelector",
   Callback = function(Options)
      Window.ModifyTheme(Options[1])
   end,
})

SettingsTab:CreateLabel("ReverbLib Example")

SettingsTab:CreateParagraph({
   Title = "Loader Note",
   Content = "ReverbLib no longer includes a built-in key system. Run your loader checks before creating the UI."
})

ReverbLib:LoadConfiguration()
