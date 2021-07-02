#!/usr/bin/env lua
--[[
	tess
	File:/src/tess.lua
	Date:2021.07.02
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local io		= require("io");
local string		= require("string");

local modStyle		= require("Style_Document");
local modOutput		= require("Output_PlainText");
local modParser		= require("Parser");

local usage_print	= function()
	print("tess");
	print("Usage:");
	print("tess SOURCE_NAME OUTPUT_NAME");
	return;
end

local sourceFileName	= arg[1];
local outputFileName	= arg[2];

--[[	Check the arguments	]]
if type(sourceFileName) ~= "string"  or
   type(outputFileName) ~= "string" then
	usage_print();
	return -1;
end

local output		= modOutput.Output(outputFileName);
local style		= modStyle.Style(output);
local parser		= modParser.Parser(style);

local sourceFile= assert(io.open(sourceFileName,"r"));
local source	= sourceFile:read("a");
sourceFile:close();

local status,reason = pcall(parser,source);
if not status
then
	if type(reason) == "table"
	then
		io.stderr:write(string.format("Error:\n\tIn %s:%s\n",
					      reason.phase,reason.reason));
		return -1;
	else
		io.stderr:write(string.format("Oops!An error occured.\t\n%s\n",reason));
		return -1;
	end
end

style:close();
output:close();

return 0;
