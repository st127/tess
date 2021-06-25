--[[
	tess
	File:/src/Style.lua
	Date:2021.06.25
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local lineLength <const> = 80;

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

cmdList.line = function(self)
	self.output:nl();
	self.output:text(string.rep("=",lineLength));
	self.output:nl();
	return;
end

cmdList.strong	= function(self)
	self.output:strong(true);
	return;
end

cmdList.estrong = function(self)
	self.output:strong(false);
	return;
end

cmdList.em	= function(self)
	self.output:em(true);
	return;
end

cmdList.eem	= function(self)
	self.output:em(false);
	return;
end

--------------------------------------------------------

ptsMethod.cmd = function(self,cmd)
	cmdList[cmd](self);
	return;
end

ptsMethod.text = function(self,text)
	self.output:text(text);
	return;
end

ptsMethod.close= function(self)
	return;
end

return {
	Style = Style,
       };
