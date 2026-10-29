-- SettingsTab.luau (чистая версия без обфускации и проверок)
return function(Window)
	local Library = Abysall.Interface.Library
	local SaveManager = Abysall.Interface.SaveManager
	local ThemeManager = Abysall.Interface.ThemeManager
	
	-- Создаём вкладку Settings
	local SettingsTab = Window:AddTab("Settings")
	
	-- Settings Tab
	SaveManager:SetLibrary(Library)
	SaveManager:SetFolder("Hexware/Doors")
	
	ThemeManager:SetLibrary(Library)
	ThemeManager:SetFolder("Hexware/Themes")
	
	SaveManager:BuildConfigSection(SettingsTab)
	ThemeManager:ApplyToTab(SettingsTab)
	
	-- Menu Keybind
	Library.KeybindFrame.Visible = false
	Library:OnUnload(function()
		Library.Unloaded = true
	end)
	
	-- Default menu key
	local MenuGroup = SettingsTab:AddLeftGroupbox("Menu")
	MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
		Default = "RightShift",
		NoUI = true,
		Text = "Menu keybind"
	})
	
	Library.ToggleKeybind = Library.Options.MenuKeybind
end
