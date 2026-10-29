-- SettingsTab.luau деобф))))))))
return function(Window)
	local Library = Abysall.Interface.Library
	local SaveManager = Abysall.Interface.SaveManager
	local ThemeManager = Abysall.Interface.ThemeManager
	
	-- Settings Tab
	SaveManager:SetLibrary(Library)
	SaveManager:SetFolder("Hexware/Doors")
	
	ThemeManager:SetLibrary(Library)
	ThemeManager:SetFolder("Hexware/Themes")
	
	SaveManager:BuildConfigSection(Window)
	ThemeManager:ApplyToTab(Window)
	
	-- Menu Keybind
	Library.KeybindFrame.Visible = false
	Library:OnUnload(function()
		Library.Unloaded = true
	end)
	
	-- Default menu key
	local MenuGroup = Window:AddTab("Settings"):AddLeftGroupbox("Menu")
	MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
		Default = "RightShift",
		NoUI = true,
		Text = "Menu keybind"
	})
	
	Library.ToggleKeybind = Library.Options.MenuKeybind
end
