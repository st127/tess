# tess
# Makefile for tess
# File:/src/Makefile
# Date:2021.07.02
# By MIT License.
# Copyright(C) 2021 tess developers.All rights reserved.

# Tools
LMERGE		:= lmerge
CP		:= cp
CHMOD		:= chmod
REMOVE		:= rm

# Files
STYLE_SRC	:= Style_Document.lua
OUTPUT_SRC	:= Output_HTML.lua Output_PlainText.lua
SRC		:= tess.lua Parser.lua $(STYLE_SRC) $(OUTPUT_SRC)
OUTPUT_SCRIPT	:= tess

# Directories
DIR_INSTALL	:= /bin/

default: install

install: $(SRC)
	$(LMERGE) $(SRC) -m tess.lua -ishb -o $(OUTPUT_SCRIPT)
	$(CHMOD) 777 $(OUTPUT_SCRIPT)
	$(CP) $(OUTPUT_SCRIPT) $(DIR_INSTALL) 

clean:
	$(REMOVE) $(OUTPUT_SCRIPT)
