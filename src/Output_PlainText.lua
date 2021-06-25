--[[
	tess
	File:/src/Output_PlainText.lua
	Date:2021.06.25
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local lineWidth <const>	= 80;
local tabSize	<const> = 8;

local string		= require("string");
local io		= require("io");
local utf8		= require("utf8");
local table		= require("table");

local outputMethod	= {};
local outputMetaTable	= {
				__index = outputMethod,
			  };

local Output		= function(name)
	local output = {
			status = {
					pos	= 0,
					mode	= false,
				 },
			file   = assert(io.open(name,"w"));
		       };

	return setmetatable(output,outputMetaTable);
end

local is_newline	= function(char)
	return char == '\n';
end

local auto_nl		= function(self,text)
	local result = {};
	
	local temp   = "";
	for char in string.gmatch(text,utf8.charpattern)
	do
		local width = 1;
		if #char > 1
		then
			width = 2;
		elseif is_newline(char)
		then
			width = 0;
			self.status.pos = 0;
		end

		if self.status.pos + width > lineWidth and
		   not self.status.native
		then
			table.insert(result,temp);
			temp = char;
			self.status.pos = width;
		elseif char == '\t'
		then
			local fillWidth = tabSize - self.status.pos % tabSize;

			if self.status.pos + fillWidth > lineWidth and
			   not self.status.mode
			then
				self.status.pos = 0;
				table.insert(result,temp);
			else
				temp = temp .. string.rep(" ",fillWidth);
				self.status.pos = self.status.pos + fillWidth;
			end
		else
			temp = temp .. char;
			self.status.pos = self.status.pos + width;
		end
	end
	
	table.insert(result,temp);

	return table.concat(result,"\n");
end

local file_write	= function(self,text)
	self.file:write(self.status.native and text or auto_nl(self,text));
end

outputMethod.text	= function(self,text)
	file_write(self,text);
	return;
end

outputMethod.nl		= function(self,n)
	n = n or 1;
	file_write(self,string.rep("\n",n));
	return;
end

outputMethod.space	= function(self,n)
	n = n or 1;
	file_write(self,string.rep(" ",n));
	return;
end

outputMethod.strong	= function(self,mode)
	file_write(self,"_");
	return;
end

outputMethod.em		= function(self,mode)
	file_write(self,"*");
	return;
end

outputMethod.native	= function(self,mode)
	self.status.mode = mode;
end

outputMethod.close	= function(self)
	self.file:close();
	return;
end

return {
	Output = Output,
       };
