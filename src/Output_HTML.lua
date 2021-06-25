--[[
	tess
	File:/src/Output_HTML.lua
	Date:2021.06.25
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local beginningOfFile <const> = [[
<html>
<body>
]];
local endOfFile <const>	= [[
</body>
</html>
]];

local string		= require("string");
local io		= require("io");

local ohMethod		= {};
local ohMetaTable	= {
				__index = ohMethod,
			  };

local Output = function(fileName)
	local output	= {};
	output.file	= assert(io.open(fileName,"w"));
	output.file:write(beginningOfFile);
	output.mode	= false;
	output.htmlStyle= {};
	output.styleUsed= false;

	return setmetatable(output,ohMetaTable);
end

local file_write	= function(self,str)
	return self.file:write(str);
end

local style_set		= function(self,key,value)
	self.htmlStyle[key] = value;
	return;
end

local style_spawn	= function(self)
	if self.styleUsed then
		local temp = {" style=\""};
		local count= 0;
		for key,value in pairs(self.htmlStyle)
		do
			table.append(temp,string.format("%s:%s;",key,tostring(value)));
		end
		table.append("\"");
		return table.concat(temp);
	end
	return "";
end

local lable_write	= function(self,lable)
	file_write(self,string.format("<%s %s>",lable,style_spawn(self)));
	return;
end

ohMethod.space		= function(self,num)
	num = num or 1;
	file_write(self,string.rep("&ensp;",num));
	return;
end

ohMethod.nl		= function(self,num)
	num = num or 1;
	file_write(self,string.rep("<br/>",num));
	return;
end

local convert		= function(self,text)
	text = string.gsub(text," ","&nbsp;");
	text = string.gsub(text,"\n","<br/>");
	text = string.gsub(text,"<","&lt;");
	text = string.gsub(text,">","&gt;");
	return text;
end

local convertn		= function(self,text)
	text = string.gsub(text,"<","&lt;");
	text = string.gsub(text,">","&gt;");
	return text;
end

ohMethod.text		= function(self,text)
	file_write(self,self.mode == true and 
			convertn(self,text) or
			convert(self,text));
	return;
end

ohMethod.native		= function(self,mode)
	self.mode = mode;
	file_write(self,mode and "<pre><code>" or "</code></pre>");
	return;
end

ohMethod.close		= function(self,mode)
	self.file:close();
	return;
end

return {
	Output = Output,
       };
