--[[
	tess
	File:/src/Output_PlainText.lua
	Date:2021.06.19
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local string = require("string");
local io     = require("io");

local ptoMethod    = {};
local ptoMetaTable = {
			__index = ptoMethod,
		     };
