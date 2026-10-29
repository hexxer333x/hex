-- Cleaned InfoTab.luau деобфусцированный))))))
return function(Window)
	local Library = Abysall.Interface.Library
	
	local function CloneRef(obj)
		if Abysall and Abysall.Environment.cloneref then
			return Abysall.Environment.cloneref(obj)
		else
			return obj
		end
	end
	
	local Services = setmetatable({}, {
		__index = function(self, name)
			return CloneRef(game:GetService(name))
		end
	})
	
	local LocalPlayer = Services.Players.LocalPlayer
	
	-- Changelog (убраны сообщения о краже)
	local changelog = {
		"<font color='rgb(0, 255, 0)'>+ Hexware fork created</font>",
		"<font color='rgb(255, 0, 0)'>- Removed telemetry</font>"
	}
	
	local InfoTab = Window:AddTab("Info", "user")
	
	-- User Info Group
	local UserGroup = InfoTab:AddLeftGroupbox("User Info")
	local ThumbnailSize = Enum.ThumbnailSize.Size420x420
	local ThumbnailType = Enum.ThumbnailType.HeadShot
	local UserThumb = Services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, ThumbnailType, ThumbnailSize)
	
	UserGroup:AddImage("UserIcon", {Image = UserThumb})
	UserGroup:AddLabel("ID: " .. LocalPlayer.Name, true)
	UserGroup:AddLabel("Total Executions: " .. (Abysall.TotalExecutions or "N/A"), true)
	
	-- Credits Group
	local CreditsGroup = InfoTab:AddRightGroupbox("Credits")
	local credits = {
		"<font color='rgb(0, 255, 255)'>Hexxer333 — Owner of the Continued Script</font>",
		"<font color='rgb(50, 205, 50)'>" .. LocalPlayer.Name .. " — For Using This Script</font>"
	}
	
	for _, credit in pairs(credits) do
		CreditsGroup:AddLabel(credit, true)
	end
	
	-- Changelog Group
	local ChangelogGroup = InfoTab:AddRightGroupbox("Changelog")
	for _, change in pairs(changelog) do
		ChangelogGroup:AddLabel(change, true)
	end
	
	-- Executor Info Group
	local executor_name, executor_version = Abysall.Environment.identifyexecutor and Abysall.Environment.identifyexecutor() or "Unknown", nil
	local ExecutorGroup = InfoTab:AddRightGroupbox("Executor Info")
	ExecutorGroup:AddLabel("Name: " .. executor_name, true)
	ExecutorGroup:AddLabel("Version: " .. (executor_version or "N/A"), true)
	ExecutorGroup:AddDivider()
	ExecutorGroup:AddLabel("Test Result: ", true)
	
	-- Environment test results (если есть)
	if Abysall.Environment.Results then
		for _, result in pairs(Abysall.Environment.Results) do
			result = result:gsub("<", "(")
			result = result:gsub(">", ")")
			ExecutorGroup:AddLabel(result, true)
		end
	else
		ExecutorGroup:AddLabel("✅ Basic functions loaded", true)
	end
	
	-- Scripts Group
	local ScriptsGroup = InfoTab:AddLeftGroupbox("Scripts")
	ScriptsGroup:AddButton("InfiniteYield", {
		Text = "Infinite Yield",
		Default = false,
		Tooltip = "Runs infinite yield.",
		Func = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		end
	})
	
	ScriptsGroup:AddButton("Dex", {
		Text = "Dex",
		Default = false,
		Tooltip = "Runs Dex.",
		Func = function()
			Library:Notify("Please wait.")
			loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
		end
	})
	
	-- Community Group
	InfoTab:AddLeftGroupbox("Community"):AddButton("Copy Discord Invite", function()
		toclipboard("https://discord.gg/BGyQMjVYCb")
		Library:Notify("Discord invite copied.")
	end)
end
