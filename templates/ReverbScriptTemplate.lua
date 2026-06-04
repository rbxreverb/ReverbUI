-- Reverb Script Template
-- Copy this file when starting a new game script.

local SCRIPT_NAME = "CHANGE_ME"
local SCRIPT_VERSION = "v1.0.0"
local SCRIPT_UPDATED = "04 Jun 26"
local SCRIPT_AUTHOR = "Reverb"
local SCRIPT_ID = "change_me" -- Keep this stable once public. Used for config files and flags.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local ReverbLib = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/rbxreverb/ReverbUI/refs/heads/main/source.lua"
))()

local Window = ReverbLib:CreateWindow({
	Name = SCRIPT_NAME,
	LoadingTitle = "Reverb",
	LoadingSubtitle = "Loading Hub",
	Icon = "reverb",
	Theme = "Reverb",
	ToggleUIKeybind = "K",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Reverb Hub",
		FileName = SCRIPT_ID,
	},
	ScriptName = SCRIPT_NAME,
	ScriptVersion = SCRIPT_VERSION,
	Author = SCRIPT_AUTHOR,
	LastUpdated = SCRIPT_UPDATED,
})

local MainTab = Window:CreateTab("Main", "home")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- Optional. Remove this block if the script should not have configs.
Window:CreateConfigTab({
	Name = "Configs",
	Icon = "save",

	-- Optional preset configs. Uncomment and edit when a game needs quick presets.
	-- Preset keys must match your element Flag names exactly.
	-- Dropdown values should be wrapped in a table, for example {"Default"}.
	-- Presets = {
	-- 	["Legit"] = {
	-- 		[SCRIPT_ID.."_ExampleToggle"] = false,
	-- 		[SCRIPT_ID.."_ExampleSlider"] = 16,
	-- 		[SCRIPT_ID.."_ExampleMode"] = {"Default"},
	-- 	},
	-- 	["Fast"] = {
	-- 		[SCRIPT_ID.."_ExampleToggle"] = true,
	-- 		[SCRIPT_ID.."_ExampleSlider"] = 50,
	-- 		[SCRIPT_ID.."_ExampleMode"] = {"Default"},
	-- 	},
	-- },
})

-- Optional. Keep this if the script has public updates to show.
Window:CreateChangelogTab({
	Name = "Changelog",
	Icon = "history",
	ScriptName = SCRIPT_NAME,
	Entries = {
		{
			Version = SCRIPT_VERSION,
			Date = SCRIPT_UPDATED,
			Title = "Initial release",
			Changes = {
				"Added the first script features.",
			},
		},
	},
})

local state = {
	ExampleToggle = false,
	ExampleSlider = 16,
	ExampleMode = "Default",
}

local scriptRunning = true
local cleanupTasks = {}

local function addCleanup(cleanup)
	table.insert(cleanupTasks, cleanup)
	return cleanup
end

local function cleanup()
	scriptRunning = false
	for _, item in ipairs(cleanupTasks) do
		pcall(function()
			if typeof(item) == "RBXScriptConnection" then
				item:Disconnect()
			elseif type(item) == "function" then
				item()
			elseif type(item) == "table" and item.Disconnect then
				item:Disconnect()
			end
		end)
	end
	table.clear(cleanupTasks)
end

local function notify(title, content, image)
	ReverbLib:Notify({
		Title = title or "Reverb",
		Content = content or "",
		Duration = 4,
		Image = image or "info",
	})
end

local function getCharacter()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
	local character = getCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end

MainTab:CreateSection("Main")

MainTab:CreateToggle({
	Name = "Example Toggle",
	CurrentValue = false,
	Flag = SCRIPT_ID.."_ExampleToggle",
	Callback = function(value)
		state.ExampleToggle = value
	end,
})

MainTab:CreateSlider({
	Name = "Example Slider",
	Range = {0, 100},
	Increment = 1,
	Suffix = "",
	CurrentValue = state.ExampleSlider,
	Flag = SCRIPT_ID.."_ExampleSlider",
	Callback = function(value)
		state.ExampleSlider = value
	end,
})

MainTab:CreateDropdown({
	Name = "Example Mode",
	Options = {"Default"},
	CurrentOption = {state.ExampleMode},
	MultipleOptions = false,
	Flag = SCRIPT_ID.."_ExampleMode",
	Callback = function(option)
		state.ExampleMode = type(option) == "table" and option[1] or option
	end,
})

MainTab:CreateButton({
	Name = "Example Button",
	Callback = function()
		notify("Reverb", "Button clicked.", "check")
	end,
})

SettingsTab:CreateSection("Script")

SettingsTab:CreateButton({
	Name = "Unload Script",
	Callback = function()
		cleanup()
		ReverbLib:Destroy()
	end,
})

task.spawn(function()
	while scriptRunning do
		task.wait(0.2)
		if state.ExampleToggle then
			-- Put repeated feature logic here.
			-- Keep this loop light. Do not create new connections inside it.
		end
	end
end)

addCleanup(LocalPlayer.CharacterAdded:Connect(function()
	-- Re-apply character-based feature state here if needed.
end))
