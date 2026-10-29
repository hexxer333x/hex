-- Cleaned Environment.luau
local Environment = {}

local Global = setmetatable({}, {
	__index = function(Self, Name)
		return getfenv(0)[Name]
	end,
})

-- Базовые функции executor
local executor_funcs = {
	"getgenv", "getrenv", "getfenv", "setfenv",
	"readfile", "writefile", "makefolder", "isfolder", "isfile", "listfiles", "delfile", "delfolder",
	"appendfile", "loadfile", "getcustomasset",
	"loadstring", "cloneref", "clonefunction",
	"hookfunction", "hookmetamethod", "getnamecallmethod", "restorefunction", "isfunctionhooked",
	"gethui", "sethiddenproperty", "gethiddenproperty",
	"firesignal", "replicatesignal", "getcallbackvalue", "getconnections",
	"getrawmetatable", "setrawmetatable", "setreadonly", "isreadonly",
	"fireproximityprompt", "fireclickdetector", "firetouchinterest",
	"getthreadidentity", "setthreadidentity",
	"isnetworkowner", "isexecutorclosure",
	"getgc", "getinstances", "getnilinstances",
	"Drawing",
	"keypress", "keyrelease", "mouse1click", "mouse1press", "mouse1release",
	"request", "http_request", "syn_request",
	"queue_on_teleport", "queueonteleport",
	"setclipboard", "toclipboard",
	"identifyexecutor", "getexecutorname",
	"newcclosure", "require"
}

-- Заполняем Environment доступными функциями
for _, func_name in ipairs(executor_funcs) do
	local func = Global[func_name]
	if func then
		Environment[func_name] = func
	end
end

-- Дополнительные алиасы
Environment.HttpGet = function(url)
	return game:HttpGet(url)
end
Environment.request = Environment.request or Environment.http_request or Environment.syn_request
Environment.cloneref = Environment.cloneref or function(obj) return obj end

-- Базовые Drawing если нет
if not Environment.Drawing and Global.Drawing then
	Environment.Drawing = {
		new = Global.Drawing.new,
		Fonts = Global.Drawing.Fonts or {}
	}
end

return Environment
