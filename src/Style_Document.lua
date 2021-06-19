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
	local style  = {};
	style.output = output;
	return setmetatable(style,ptsMetaTable);
end

local cmdList = {};
cmdList.p	= function(self)
	self.output:space(8);
	return;
end

cmdList.ep	= function(self)
	self.output:nl();
	return;
end

cmdList.space	= function(self)
	self.output:space();
	return;
end

cmdList.code = function(self)
	self.output:native(true);
	return;
end

cmdList.ecode = function(self)
	self.output:native(false);
end

ptsMethod.cmd = function(self,cmd)
	cmdList[cmd](self);
	return;
end

ptsMethod.text = function(self,text)
	self.output:text(text);
	return;
end

return {
	Style = Style,
       };
