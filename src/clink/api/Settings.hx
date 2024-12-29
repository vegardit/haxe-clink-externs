/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.internal.EitherType3;
import clink.util.LuaArray;

/**
 * https://chrisant996.github.io/clink/clink.html#settings
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/settings_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("settings")
extern class Settings {
   /** https://chrisant996.github.io/clink/clink.html#settings.add
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L383 */
   @:SinceClink("1.0.0")
   static function add(name:String, defaultValue:EitherType3<Bool, Int, String>, ?shortDescr:String, ?longDescr:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#settings.add
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L383 */
   @:SinceClink("1.0.0")
   @:native("add")
   static function addEnum(name:String, enumValues:LuaArray<String>, ?shortDescr:String, ?longDescr:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#settings.clear
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L172 */
   @:SinceClink("1.7.0")
   static function clear(name:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#settings.formatcolor
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L507 */
   @:SinceClink("1.7.0")
   static function formatcolor(code:String, compat:Bool = false):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#settings.get
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L23 */
   @:SinceClink("1.0.0")
   static function get(name:String, descriptive:Bool = false):EitherType3<Bool, Int, String>;

   /** https://chrisant996.github.io/clink/clink.html#settings.formatcolor
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L477 */
   @:SinceClink("1.7.0")
   static function parsecolor(code:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#settings.set
    * https://github.com/chrisant996/clink/blob/521fa70ed480621d3004e6dfca35aa0f4a56c5d0/clink/lua/src/settings_api.cpp#L100 */
   @:SinceClink("1.0.0")
   static function set(name:String, value:EitherType3<Bool, Int, String>):Bool;
}
