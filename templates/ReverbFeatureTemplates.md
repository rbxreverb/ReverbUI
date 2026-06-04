# Reverb Feature Templates

Use this document when asking AI to build one feature at a time for a Reverb script.

## AI Prompt Rules

Paste this at the top of feature requests:

```text
Build this as a ReverbUI feature. Use state-based toggles. Do not put infinite loops inside toggle callbacks. Do not create duplicate event connections when a toggle is clicked multiple times. Use stable unique Flag names. Store connections and disconnect them when disabled or on cleanup. Keep code small to avoid Luau local register pressure. Only add the feature code requested.
```

## Naming Rules

- Use one stable `SCRIPT_ID` per script.
- Use flags like `SCRIPT_ID.."_AutoFarm"` and never change public flag names unless you want old configs to stop applying.
- Use tabs for normal script areas like `Main`, `Farm`, `Visuals`, `Player`.
- Use panels only when talking about Reverb internal search/account/settings panels.

## Basic Button

```lua
MainTab:CreateButton({
	Name = "Do Action",
	Callback = function()
		-- One-time action here.
		notify("Reverb", "Action complete.", "check")
	end,
})
```

## State Toggle

Use this for most on/off features.

```lua
state.AutoFeature = false

MainTab:CreateToggle({
	Name = "Auto Feature",
	CurrentValue = false,
	Flag = SCRIPT_ID.."_AutoFeature",
	Callback = function(value)
		state.AutoFeature = value
	end,
})

task.spawn(function()
	while task.wait(0.2) do
		if state.AutoFeature then
			-- Repeating feature logic here.
		end
	end
end)
```

## Toggle With Connection

Use this when the feature listens to an event. It prevents duplicate connections.

```lua
local featureConnection = nil

local function setFeatureEnabled(enabled)
	if featureConnection then
		featureConnection:Disconnect()
		featureConnection = nil
	end

	if not enabled then
		return
	end

	featureConnection = RunService.Heartbeat:Connect(function()
		-- Event-based logic here.
	end)
end

MainTab:CreateToggle({
	Name = "Connected Feature",
	CurrentValue = false,
	Flag = SCRIPT_ID.."_ConnectedFeature",
	Callback = function(value)
		state.ConnectedFeature = value
		setFeatureEnabled(value)
	end,
})

addCleanup(function()
	if featureConnection then
		featureConnection:Disconnect()
		featureConnection = nil
	end
end)
```

## Slider

```lua
state.WalkSpeed = 16

MainTab:CreateSlider({
	Name = "Walk Speed",
	Range = {16, 100},
	Increment = 1,
	Suffix = " Speed",
	CurrentValue = state.WalkSpeed,
	Flag = SCRIPT_ID.."_WalkSpeed",
	Callback = function(value)
		state.WalkSpeed = value
		local humanoid = getHumanoid()
		if humanoid then
			humanoid.WalkSpeed = value
		end
	end,
})
```

## Dropdown

```lua
state.Mode = "Legit"

MainTab:CreateDropdown({
	Name = "Mode",
	Options = {"Legit", "Fast", "Safe"},
	CurrentOption = {state.Mode},
	MultipleOptions = false,
	Flag = SCRIPT_ID.."_Mode",
	Callback = function(option)
		state.Mode = type(option) == "table" and option[1] or option
	end,
})
```

## Multi Dropdown

```lua
state.SelectedItems = {}

MainTab:CreateDropdown({
	Name = "Selected Items",
	Options = {"Item 1", "Item 2", "Item 3"},
	CurrentOption = {},
	MultipleOptions = true,
	Flag = SCRIPT_ID.."_SelectedItems",
	Callback = function(options)
		state.SelectedItems = type(options) == "table" and options or {}
	end,
})
```

## Input

```lua
state.TargetName = ""

MainTab:CreateInput({
	Name = "Target Name",
	CurrentValue = "",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Flag = SCRIPT_ID.."_TargetName",
	Callback = function(value)
		state.TargetName = tostring(value or "")
	end,
})
```

## Keybind

```lua
MainTab:CreateKeybind({
	Name = "Feature Key",
	CurrentKeybind = "G",
	HoldToInteract = false,
	Flag = SCRIPT_ID.."_FeatureKey",
	Callback = function()
		state.AutoFeature = not state.AutoFeature
		notify("Reverb", "Feature toggled.", "zap")
	end,
})
```

## Label And Paragraph

```lua
MainTab:CreateLabel("Status: Ready", "check", Color3.fromRGB(0, 226, 248), true)

local statusParagraph = MainTab:CreateParagraph({
	Title = "Status",
	Content = "Waiting for action.",
})

statusParagraph:Set({
	Title = "Status",
	Content = "Running.",
})
```

## Color Picker

```lua
state.HighlightColor = Color3.fromRGB(0, 226, 248)

MainTab:CreateColorPicker({
	Name = "Highlight Color",
	Color = state.HighlightColor,
	Flag = SCRIPT_ID.."_HighlightColor",
	Callback = function(color)
		state.HighlightColor = color
	end,
})
```

## Optional Config Tab

Only add this when the script has useful saved settings.

```lua
Window:CreateConfigTab({
	Name = "Configs",
	Icon = "save",
})
```

Remove it completely for scripts that do not need configs.

## Optional Changelog Tab

```lua
Window:CreateChangelogTab({
	Name = "Changelog",
	Icon = "history",
	ScriptName = SCRIPT_NAME,
	Entries = {
		{
			Version = "v1.0.0",
			Date = "04 Jun 26",
			Title = "Initial release",
			Changes = {
				"Added core features.",
			},
		},
	},
})
```

## Notification

```lua
ReverbLib:Notify({
	Title = "Reverb",
	Content = "Message here.",
	Duration = 4,
	Image = "info",
})
```

## Cleanup Pattern

Every script should have this available.

```lua
local cleanupTasks = {}

local function addCleanup(cleanup)
	table.insert(cleanupTasks, cleanup)
	return cleanup
end

local function cleanup()
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
```

## Efficient Feature Checklist

- Cache services once at the top.
- Keep callbacks short.
- Toggles set state; loops read state.
- Do not create loops inside toggle callbacks.
- Do not create connections inside loops.
- Disconnect event connections when disabling features.
- Use `task.wait(0.2)` or slower for most repeated logic.
- Only use fast `Heartbeat` logic when the feature truly needs it.
- Use `pcall` around risky game-specific access, not every normal line.
- Keep feature code in small functions to avoid Luau local register pressure.

## Useful AI Request Shape

```text
Create one ReverbUI feature for [feature name].
Add it to [tab name].
Use this flag: SCRIPT_ID.."_[FlagName]".
It should store state in the shared state table.
It should not create duplicate loops or event connections.
It should include cleanup if it uses connections.
Only return the code for this feature and any helper functions it needs.
```
