--[[
	tess
	File:/src/Style.lua
	Date:2021.06.19
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local string = require("string");

local Parser = function (style)
	return function(src)
		local pattern	= "()\\(%w-)%s+()";
		local pos	= 1;

		while true
		do
			local start,cmd,endP = 
				string.match(src,pattern,pos);

			if not cmd then
				break;
			end

			style:text(string.sub(src,pos,start-1));
			style:cmd(cmd);
			pos = endP;
		end
		return;
	end
end			

return {
	Parser = Parser,
       };
