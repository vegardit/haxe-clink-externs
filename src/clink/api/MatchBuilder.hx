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
@:ClinkAPI("1.7.7")
extern class MatchBuilder {
   /** https://chrisant996.github.io/clink/clink.html#builder:addmatch */
   @:SinceClink("1.0.0")
   @:native("addmatch")
   overload function addMatch(match:String, ?type:String):Bool;

   @:SinceClink("1.0.0")
   @:native("addmatch")
   overload function addMatch(match:Match):Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:addmatches */
   @:SinceClink("1.0.0")
   @:native("addmatches")
   overload function addMatches(matches:LuaArray<String>):Bool;

   @:SinceClink("1.0.0")
   @:native("addmatches")
   overload function addMatches(matches:LuaArray<String>, ?type:String):Bool;

   @:SinceClink("1.0.0")
   @:native("addmatches")
   overload function addMatches(matches:LuaArray<Match>):Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:isempty */
   @:SinceClink("1.3.9")
   @:native("isempty")
   function isEmpty():Bool;

   /** https://chrisant996.github.io/clink/clink.html#builder:setappendcharacter */
   @:SinceClink("1.1.2")
   @:native("setappendcharacter")
   function setAppendCharacter(?append:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setforcequoting */
   @:SinceClink("1.4.19")
   @:native("setforcequoting")
   function setForceQuoting():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setfullyqualify */
   @:SinceClink("1.5.3")
   @:native("setfullyqualify")
   function setFullyQualify(fullyQualify:Bool = true):Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setnosort */
   @:SinceClink("1.3.3")
   @:native("setnosort")
   function setNoSort():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setsuppressappend */
   @:SinceClink("1.1.2")
   @:native("setsuppressappend")
   function setSuppressAppend():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setsuppressquoting */
   @:SinceClink("1.1.2")
   @:native("setsuppressquoting")
   function setSuppressQuoting():Void;

   /** https://chrisant996.github.io/clink/clink.html#builder:setvolatile */
   @:SinceClink("1.3.37")
   @:native("setvolatile")
   function setVolatile():Void;
}

/** https://chrisant996.github.io/clink/clink.html#builder:addmatch */
typedef Match = {
   match:String,
   /* @:SinceClink("1.2.38") */ ?display:String,
   /* @:SinceClink("1.5.4") */ ?arginfo:String,
   /* @:SinceClink("1.2.38") */ ?description:String,
   ?type:MatchTypeWithModifiers,
   /* @:SinceClink("1.3.1") */ ?appendchar:String,
   /* @:SinceClink("1.3.1") */ ?suppressappend:Bool
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
