--[[
	tess
	File:/src/Style.lua
	Date:2021.06.19
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local string = require("string");

local ptsMethod = {};
local ptsMetaTable = {__index = ptsMethod};

local Style = function(output)
	return setmetatable({},ptsMetaTable);
end

ptsMethod.cmd = function(self,cmd)
	print(string.format("Command:%s",cmd));
	return;
end

ptsMethod.text = function(self,text)
	print(string.format("Text:%s",text));
	return;
end

return {
	Style = Style,
       };
