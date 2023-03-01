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
extern class RLBuffer {
   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:beginoutput */
   @:native("beginoutput")
   function beginOutput():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:beginundogroup */ 
   @:native("beginundogroup")
   function beginUndoGroup():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:ding */
   function ding():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:endundogroup */
   @:native("endundogroup")
   function endUndoGroup():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getanchor */
   @:native("getanchor")
   function getAnchor():Null<Int>;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getargument */
   @:native("getargument")
   function getArgument():Null<Int>;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getbuffer */
   @:native("getbuffer")
   function getBuffer():String;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getcursor */
   @:native("getcursor")
   function getCursor():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:getlength */
   @:native("getlength")
   function getLength():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:insert */
   function insert(txt:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:refreshline */
   @:native("refreshline")
   function refreshLine():Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:remove */
   function remove(from:Int, to:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:setargument */
   @:native("setargument")
   function setArgument(argument:Null<Int>):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl_buffer:setcursor */
   @:native("setcursor")
   function setCursor(cursor:Int):Void;
}
