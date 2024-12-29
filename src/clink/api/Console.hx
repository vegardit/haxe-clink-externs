/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import lua.NativeIterator;
import clink.util.LuaTable;
import haxe.extern.EitherType;
import clink.util.LuaArray;

/** https://chrisant996.github.io/clink/clink.html#console
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/console_api.cpp */
@:ClinkAPI("1.7.7")
@:native("console")
extern class Console {
   /** https://chrisant996.github.io/clink/clink.html#console.cellcount
    * ```
    * >>> Console.cellCount("hello") == 5
    * ```
    */
   @:SinceClink("1.2.5")
   @:native("cellcount")
   static function cellCount(text:String):Int;

   /* https://chrisant996.github.io/clink/clink.html#console.cellcountiter */
   @:SinceClink("1.6.1")
   @:native("cellcountiter")
   static function cellCountIterator(text:String):NativeIterator<GlyphInfo>;
   
   /** https://chrisant996.github.io/clink/clink.html#console.checkinput */
   @:SinceClink("1.3.42")
   @:native("checkinput")
   static function checkInput(timeoutSeconds:Float = 0):Bool;

   /** https://chrisant996.github.io/clink/clink.html#console.ellipsify
    * ```
    * >>> Console.ellipsify("helloworld", 5).ellipsified == "hell…"
    * ```
    */
   @:SinceClink("1.7.5")
   static function ellipsify(text:String, limit:Int, mode:ElipsifyMode = ElipsifyMode.RIGHT, ellipsis:String = "…"):EllipsifyResult;

   /** https://chrisant996.github.io/clink/clink.html#console.explodeansi
    * ```
    * >>> Console.explodeAnsi("\x1b[0;1mBold\x1b[m").toArray() == [ "\x1b[0;1m", "Bold", "\x1b[m" ]
    * ```
    */
   @:SinceClink("1.6.1")
   @:native("explodeansi")
   static function explodeAnsi(text:String):LuaArray<String>;
   
   /** https://chrisant996.github.io/clink/clink.html#console.findnextline */
   @:SinceClink("1.1.21")
   @:native("findnextline")
   static function findNextLine(startingLine:Int, ?text:String, ?mode:String, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.findprevline */
   @:SinceClink("1.1.21")
   @:native("findprevline")
   static function findPrevLine(startingLine:Int, ?text:String, ?mode:String, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getcolortable */
   @:SinceClink("1.5.15")
   @:native("getcolortable")
   static function getColorTable():ColorTable;

   /** https://chrisant996.github.io/clink/clink.html#console.getcursorpos */
   @:SinceClink("1.4.28")
   @:native("getcursorpos")
   static function getCursorPos():CursorPos;

   /** https://chrisant996.github.io/clink/clink.html#console.getheight */
   @:SinceClink("1.1.20")
   @:native("getheight")
   static function getHeight():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getlinetext */
   @:SinceClink("1.1.20")
   @:native("getlinetext")
   static function getLineText(line:Int):String;

   /** https://chrisant996.github.io/clink/clink.html#console.getnumlines */
   @:SinceClink("1.1.20")
   @:native("getnumlines")
   static function getNumLines():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.gettitle
    * ```
    * >>> Console.getTitle().length > 0
    * ```
    */
   @:SinceClink("1.1.32")
   @:native("gettitle")
   static function getTitle():String;

   /** https://chrisant996.github.io/clink/clink.html#console.gettop */
   @:SinceClink("1.1.20")
   @:native("getTop")
   static function getTop():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.getwidth */
   @:SinceClink("1.1.20")
   @:native("getwidth")
   static function getWidth():Int;

   /** https://chrisant996.github.io/clink/clink.html#console.islinedefaultcolor */
   @:SinceClink("1.1.20")
   @:native("islinedefaultcolor")
   static function isLineDefaultColor(line:Int):Bool;

   /** https://chrisant996.github.io/clink/clink.html#console.linehascolor */
   @:SinceClink("1.1.21")
   @:native("linehascolor")
   static function lineHasColor(line:Int, ?attr:EitherType<Int, LuaArray<Int>>, ?mask:Mask):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.plaintext */
   @:SinceClink("1.2.5")
   static function plaintext(text:String):PlainTextResult;

   /** https://chrisant996.github.io/clink/clink.html#console.readinput */
   @:SinceClink("1.2.29")
   @:native("readinput")
   static function readInput(noCursor:Bool):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#console.screengrab */
   @:SinceClink("1.1.40")
   @:native("screengrab")
   static function screenGrab(candidatePattern:String, acceptAattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#console.scroll */
   @:SinceClink("1.1.20")
   static function scroll(mode:ScrollMode, amount:Int):Int;

   /** https://chrisant996.github.io/clink/clink.html#console.settitle */
   @:SinceClink("1.1.32")
   @:native("settitle")
   static function setTitle(title:String):Void;
}

abstract ColorTable(LuaTable<String>) from LuaTable<String> {

   public var background(get, never):Int;
   public var foreground(get, never):Int;
   public var isDefaultColorTable(get, never):Bool;

   public function get(colorIndex:Int):String {
      return this.get(colorIndex);
   }

   private function get_isDefaultColorTable():Bool {
      return (cast this.get("default")) == true;
   }

   private function get_background():Int {
      return cast this.get("background");
   }

   private function get_foreground():Int {
      return cast this.get("foreground");
   }
}


/** https://chrisant996.github.io/clink/clink.html#console.cellcountiter */
@:multiReturn
extern class GlyphInfo {
   final text:String;
   final visibleCellsCount:Int;
   final isEmoji:Bool;
}


enum abstract ElipsifyMode(String) to String {
   final RIGHT = "right";
   final LEFT = "left";
   final PATH = "path";
}


/** https://chrisant996.github.io/clink/clink.html#console.ellipsify */
@:multiReturn
extern class EllipsifyResult {
   final ellipsified:String;
   final visibleCellsCount:Int;
}

enum abstract Mask(String) to String {
   final FOREGROUND = "fore";
   final BACKGROUND = "back";
}


/** https://chrisant996.github.io/clink/clink.html#console.getcursorpos */
@:multiReturn
extern class CursorPos {
   final x:Int;
   final y:Int;
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
