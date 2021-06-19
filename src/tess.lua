--[[
	tess
	File:/src/tess.lua
	Date:2021.06.19
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local io     = require("io");
local string = require("string");

local modStyle	= require("Style_PlainText");
local modOutput	= require("Output_PlainText");
local modParser = require("Parser");

local style	= modStyle.Style(nil);
local parser	= modParser.Parser(style);


local sourceFile= assert(io.open(arg[1],"r"));
local source	= sourceFile:read("a");
sourceFile:close();

parser(source);

return 0;
