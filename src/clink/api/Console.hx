/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import haxe.extern.EitherType;

import clink.util.LuaArray;

/** https://chrisant996.github.io/clink/clink.html#console
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/console_api.cpp */
@:native("console")
extern class Console {
   /** https://chrisant996.github.io/clink/clink.html#console.cellcount
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/console_api.cpp#L83 */
   @:native("cellcount")
   static function cellCount(text:String):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.checkinput
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/console_api.cpp#L643 */
   @:native("checkinput")
   static function checkInput(?timeout:Int):Bool;

   /** https://chrisant996.github.io/clink/clink.html#console.findnextline
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/console_api.cpp#L553 */
   @:native("findnextline")
   static function findNextLine(startingLine:Int, ?text:String, ?mode:String, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.findprevline
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/console_api.cpp#L507 */
   @:native("findprevline")
   static function findPrevLine(startingLine:Int, ?text:String, ?mode:String, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getheight */
   @:native("getheight")
   static function getHeight():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getlinetext */
   @:native("getlinetext")
   static function getLineText(line:Int):String;

   /** https://chrisant996.github.io/clink/clink.html#console.getnumlines */
   @:native("getnumlines")
   static function getNumLines():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.gettitle
    * ```
    * >>> Console.getTitle().length > 0
    * ```
    */
   @:native("gettitle")
   static function getTitle():String;

   /** https://chrisant996.github.io/clink/clink.html#console.gettop */
   @:native("getTop")
   static function getTop():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getwidth */
   @:native("getwidth")
   static function getWidth():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.islinedefaultcolor */
   @:native("islinedefaultcolor")
   static function isLineDefaultColor(line:Int):Bool;

   /** https://chrisant996.github.io/clink/clink.html#console.linehascolor */
   @:native("linehascolor")
   static function lineHasColor(line:Int, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.plaintext */
   static function plaintext(text:String):PlainTextResult;

   /** https://chrisant996.github.io/clink/clink.html#console.readinput */
   @:native("readinput")
   static function readInput(noCursor:Bool):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#console.scroll */
   static function scroll(mode:ScrollMode, amount:Int):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.screengrab */
   @:native("screengrab")
   static function screenGrab(candidatePattern:String, acceptAattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#console.settitle */
   @:native("settitle")
   static function setTitle(title:String):Void;
}

enum abstract Mask(String) to String {
   final FOREGROUND = "fore";
   final BACKGROUND = "back";
}


/** https://chrisant996.github.io/clink/clink.html#console.plaintext */
@:multiReturn
extern class PlainTextResult {
   final text:String;
   final visibleCellsCount:Int;
}

/** https://chrisant996.github.io/clink/clink.html#console.scroll */
enum abstract ScrollMode(String) to String {
   final LINE = "line";
   final PAGE = "page";
   final END = "end";
   final ABSOLUTE = "absolute";
}
