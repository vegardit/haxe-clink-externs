/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

/** 
 * https://chrisant996.github.io/clink/clink.html#line_state
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/line_state_lua.cpp
 */
extern class LineState {
   @:native("getcommandoffset")
   function getCommandOffset():Int;

   @:native("getcommandwordindex")
   function getCommandWordIndex():Int;

   @:native("getcursor")
   function getCursor():Int;

   @:native("getendword")
   function getEndWord():String;

   @:native("getline")
   function getLine():String;

   @:native("getword")
   function getWord(index:Int):String;

   @:native("getwordcount")
   function getWordCount():Int;

   @:native("getwordinfo")
   function getWordInfo(index:Int):WordInfo;
}

typedef WordInfo = {
   offset:Int,
   length:Int,
   quoted:Bool,
   delim:String,
   ?alias:Bool,
   ?redir:Bool
}
