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
@:ClinkAPI("1.7.7")
extern class LineState {
   @:SinceClink("1.0.0")
   @:native("getcommandoffset")
   function getCommandOffset():Int;

   @:SinceClink("1.2.27")
   @:native("getcommandwordindex")
   function getCommandWordIndex():Int;

   @:SinceClink("1.0.0")
   @:native("getcursor")
   function getCursor():Int;

   @:SinceClink("1.0.0")
   @:native("getendword")
   function getEndWord():String;

   @:SinceClink("1.6.2")
   @:native("getendwordoffset")
   function getEndWordOffset():Int;

   @:SinceClink("1.0.0")
   @:native("getline")
   function getLine():String;

   @:SinceClink("1.6.1")
   @:native("getrangelength")
   function getRangeLength():Int;

   @:SinceClink("1.6.1")
   @:native("getrangeoffset")
   function getRangeOffset():Int;

   @:SinceClink("1.0.0")
   @:native("getword")
   function getWord(index:Int):String;

   @:SinceClink("1.0.0")
   @:native("getwordcount")
   function getWordCount():Int;

   @:SinceClink("1.0.0")
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
