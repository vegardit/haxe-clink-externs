/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.util.LuaArray;

/**
 * https://chrisant996.github.io/clink/clink.html#settings
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/settings_api.cpp
 */
@:native("settings")
extern class Settings {
   /** https://chrisant996.github.io/clink/clink.html#settings.add
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/settings_api.cpp#L178 */
   static function add(name:String, defaultValue:Bool_Int_String, ?shortDescr:String, ?longDescr:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#settings.add
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/settings_api.cpp#L178 */
   @:native("add")
   static function addEnum(name:String, enumValues:LuaArray<String>, ?shortDescr:String, ?longDescr:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#settings.get
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/settings_api.cpp#L24 */
   extern static function get(name:String, ?descriptive:Bool):Null<Bool_Int_String>; // Bool|Integer|String

   /** https://chrisant996.github.io/clink/clink.html#settings.set
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/settings_api.cpp#L87 */
   extern static function set(name:String, value:Bool_Int_String):Bool;
}

abstract Bool_Int_String(Dynamic) from Bool from Int from String to Bool to Int to String {
}
