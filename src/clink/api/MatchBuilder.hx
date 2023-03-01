/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.util.LuaArray;

/**
 * https://chrisant996.github.io/clink/clink.html#builder
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/match_builder_lua.cpp
 */
extern class MatchBuilder {
   /** https://chrisant996.github.io/clink/clink.html#builder:addmatch
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L55 */
   @:native("addmatch")
   overload function addMatch(match:String, ?type:String):Bool;

   @:native("addmatch")
   overload function addMatch(match:Match):Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:addmatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L320 */
   @:native("addmatches")
   overload function addMatches(matches:LuaArray<String>):Bool;

   @:native("addmatches")
   overload function addMatches(matches:LuaArray<String>, ?type:String):Bool;
   @:native("addmatches")
   overload function addMatches(matches:LuaArray<Match>):Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:isempty
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L143 */
   @:native("isempty")
   function isEmpty():Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:setforcequoting
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L214 */
   @:native("setforcequoting")
   function setForceQuoting():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setnosort
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L224 */
   @:native("setnosort")
   function setNoSort():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setsuppressappend
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L174 */
   @:native("setsuppressappend")
   function setSuppressAppend():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setsuppressquoting
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L191 */
   @:native("setsuppressquoting")
   function setSuppressQuoting():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setvolatile
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/match_builder_lua.cpp#L234 */
   @:native("setvolatile")
   function setVolatile():Void;
}

/** https://chrisant996.github.io/clink/clink.html#builder:addmatch */
typedef Match = {
   match:String,
   ?display:String,
   ?description:String,
   ?type:MatchTypeWithModifiers,
   ?appendchar:String,
   ?suppressappend:Bool
}

/**
 * https://chrisant996.github.io/clink/clink.html#builder:addmatch
 *
 * >>> ({var t:MatchBuilder.MatchTypeWithModifiers = "file"; t;}).type == "file"
 * >>> ({var t:MatchBuilder.MatchTypeWithModifiers = "file,hidden"; t;}).hasModifier(HIDDEN) == true
 */
abstract MatchTypeWithModifiers(String) from String to String {

   public var type(get, never):MatchType;

   function get_type():MatchType {
      final modifierStart = this.indexOf(",");
      return modifierStart == -1 ? this : this.substring(0, modifierStart);
   }

   inline public function hasModifier(modifier:MatchTypeModifier) {
      return this.indexOf(modifier) > -1;
   }
}

/** https://chrisant996.github.io/clink/clink.html#builder:addmatch */
enum abstract MatchType(String) from String to String {
   final WORD = "word";
   final ARG = "arg";
   final CMD = "cmd";
   final ALIAS = "alias";
   final FILE = "file";
   final DIR = "dir";
   final NONE = "none";
}

/** https://chrisant996.github.io/clink/clink.html#builder:addmatch */
enum abstract MatchTypeModifier(String) from String to String {
   final HIDDEN = "hidden";
   final READONLY = "readonly";
   final LINK = "link";
   final ORPHANED = "orphaned";
}

/** https://chrisant996.github.io/clink/clink.html#matches
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/matches_lua.cpp#L88 */
extern class Matches {
   function getcount():Int;
   function getmatch(index:Int):Int;
   function getprefix():Int;
   function gettype(index:Int):MatchTypeWithModifiers;
}
