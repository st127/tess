--[[
	tess
	File:/src/Style.lua
	Date:2021.06.25
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local tokenSlash <const> = "\1";

local string = require("string");

local escape_prepare = function(text)
	text = string.gsub(text,"\\\\",tokenSlash);
	return text;
end

local escape = function(text)
	text = string.gsub(text,tokenSlash,"\\");
	return text;
end

local Parser = function (style)
	return function(src)
		local pattern	= "()\\(%w+)%s+()";
		local pos	= 1;

		src = escape_prepare(src);

		while true
		do
			local start,cmd,endP = 
				string.match(src,pattern,pos);

			if not cmd then
				break;
			end

			style:text(escape(string.sub(src,pos,start-1)));
			style:cmd(cmd);
			pos = endP;
		end
		style:text(escape(string.sub(src,pos)));
		return;
	end
end			

return {
	Parser = Parser,
       };
