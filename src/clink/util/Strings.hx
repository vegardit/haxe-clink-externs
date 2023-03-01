/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import lua.NativeIterator;
import lua.NativeStringTools;
import clink.api.MatchBuilder.MatchType;
import clink.util.LuaArray;

@:forwardStatics
abstract Strings(StringsNative) {

   /** https://www.lua.org/manual/5.2/manual.html#pdf-string.match */
   inline public static function findMatch(searchIn:String, luaPattern:String, ?startAt:Int):Null<String>
      return NativeStringTools.match(searchIn, luaPattern, startAt);

   /** https://www.lua.org/manual/5.2/manual.html#pdf-string.match */
   inline public static function findMatches(searchIn:String, luaPattern:String):NativeIterator<String>
      return NativeStringTools.gmatch(searchIn, luaPattern);

   /** https://www.lua.org/manual/5.2/manual.html#pdf-string.match */
   inline public static function hasMatch(searchIn:String, luaPattern:String, ?startAt:Int):Bool
      return findMatch(searchIn, luaPattern, startAt) != null;

   inline public static function startsWith(searchIn:String, searchFor:String):Bool
      return untyped __lua__("{0}:sub(1, #{1}) == {1}", searchIn, searchFor);

   inline public static function endsWith(searchIn:String, searchFor:String):Bool
      return untyped __lua__("{0}:sub(-#{1}) == {1}", searchIn, searchFor);

   /**
    * UTF-8 aware `String.toLowerCase` version
    * https://chrisant996.github.io/clink/clink.html#clink.lower
    */
   inline public static function lower(text:String):String
      return clink.api.Clink.lower(text);

   /**
    * UTF-8 aware `String.toUpperCase` version
    * https://chrisant996.github.io/clink/clink.html#clink.upper
    */
   inline public static function upper(text:String):String
      return clink.api.Clink.upper(text);

   inline public static function trim(text:String):String
      return StringTools.trim(text);
}


/**
 * https://chrisant996.github.io/clink/clink.html#string
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/string_api.cpp
 */
@:native("string")
private extern class StringsNative {
   /** https://chrisant996.github.io/clink/clink.html#string.comparematches
    * ```
    * >>> Strings.compareMatches("a", "b") == true
    * >>> Strings.compareMatches("b", "b") == false
    * >>> Strings.compareMatches("c", "b") == false
    * ```
    */
   @:native("comparematches")
   overload static function compareMatches(a:String, b:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#string.comparematches
    * ```
    * >>> Strings.compareMatches("a",  "dir", "a", "dir") == false
    * >>> Strings.compareMatches("a", "file", "a", "dir") == true
    * ```
    */
   @:native("comparematches")
   overload static function compareMatches(a:String, aType:MatchType, b:String, bType:MatchType):Bool;

   /** https://chrisant996.github.io/clink/clink.html#string.equalsi
    * ```
    * >>> Strings.equalsIgnoringCase("a", "a") == true
    * >>> Strings.equalsIgnoringCase("a", "A") == true
    * >>> Strings.equalsIgnoringCase("a", "B") == false
    * ```
    */
   @:native("equalsi")
   static function equalsIgnoringCase(a:String, b:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#string.explode */
   static function explode(text:String, ?delims:String, ?quotePair:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#string.hash */
   static function hash(text:String):Int;

   /** https://chrisant996.github.io/clink/clink.html#string.matchlen
    * ```
    * >>> Strings.matchLength("aabb", "aacc") == 2
    * ```
    */
   @:native("matchlen")
   static function matchLength(a:String, b:String):Int;
}
