/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

/**
 * https://chrisant996.github.io/clink/clink.html#rl_buffer
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/rl_buffer_lua.cpp
 */
@:ClinkAPI("1.7.7")
extern class RLBuffer {
   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:beginoutput */
   @:SinceClink("1.1.20")
   @:native("beginoutput")
   function beginOutput():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:beginundogroup */
   @:SinceClink("1.1.20") 
   @:native("beginundogroup")
   function beginUndoGroup():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:ding */
   @:SinceClink("1.1.20")
   function ding():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:endundogroup */
   @:SinceClink("1.1.20")
   @:native("endundogroup")
   function endUndoGroup():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getanchor */
   @:SinceClink("1.2.35")
   @:native("getanchor")
   function getAnchor():Null<Int>;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getargument */
   @:SinceClink("1.2.22")
   @:native("getargument")
   function getArgument():Null<Int>;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getbuffer */
   @:SinceClink("1.0.0")
   @:native("getbuffer")
   function getBuffer():String;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getcursor */
   @:SinceClink("1.1.20")
   @:native("getcursor")
   function getCursor():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getlength */
   @:SinceClink("1.1.20")
   @:native("getlength")
   function getLength():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:insert */
   @:SinceClink("1.1.20")
   function insert(txt:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:insertsuggestion */
   @:SinceClink("1.6.4")
   @:native("insertsuggestion")
   function insertSuggestion(amount:Amount = Amount.ALL):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:refreshline */
   @:SinceClink("1.4.41")
   @:native("refreshline")
   function refreshLine():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:remove */
   @:SinceClink("1.1.20")
   function remove(from:Int, to:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:setargument */
   @:SinceClink("1.2.32")
   @:native("setargument")
   function setArgument(argument:Null<Int>):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:setcommentrow */
   @:SinceClink("1.7.5")
   @:native("setcommentrow")
   function setCommentRow():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:setcursor */
   @:SinceClink("1.1.20")
   @:native("setcursor")
   function setCursor(cursor:Int):Void;
}

/** https://chrisant996.github.io/clink/clink.html#rl_buffer:insertsuggestion */
enum abstract Amount(String) to String {
   final ALL = "all";
   final WORD = "word";
   final FULLWORD = "fullword";
}