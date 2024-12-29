/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

/**
 * https://chrisant996.github.io/clink/clink.html#path
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/path_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("path")
extern class Path {

   /** https://chrisant996.github.io/clink/clink.html#path.fnmatch
    * ```
    * >>> Path.fnMatch("[[:digit:]]*", "1") == true
    * >>> Path.fnMatch("[[:digit:]]*", "a") == false
    * ```
    */
   @:SinceClink("1.4.24")
   @:native("fnmatch")
   static function fnMatch(pattern:String, path:String, ?flag:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#path.getbasename
    * ```
    * >>> Path.getBaseName("foo\\bar") == "bar"
    * ```
    */
   @:SinceClink("1.1.0")
   @:native("getbasename")
   static function getBaseName(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.getdirectory
    * ```
    * >>> Path.getDirectory("foo\\bar") == "foo"
    * ```
    */
   @:SinceClink("1.1.0")
   @:native("getdirectory")
   static function getDirectory(path:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#path.getdrive
    * ```
    * >>> Path.getDrive("C:\\foo\\bar") == "C:"
    * >>> Path.getDrive("foo\\bar") == null
    * ```
    */
   @:SinceClink("1.1.0")
   @:native("getdrive")
   static function getDrive(path:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#path.getextension
    * ```
    * >>> Path.getExtension("C:\\foo\\bar.txt") == ".txt"
    * >>> Path.getExtension("C:\\foo\\bar") == ""
    * ```
    */
   @:SinceClink("1.1.0")
   @:native("getextension")
   static function getExtension(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.getname
    * ```
    * >>> Path.getExtension("C:\\foo\\bar.txt") == ".txt"
    * >>> Path.getExtension("C:\\foo\\bar") == ""
    * ```
    */
   @:SinceClink("1.1.0")
   @:native("getname")
   static function getName(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.isexecext */
   @:SinceClink("1.1.5")
   @:native("isexecext")
   static function isExecExt(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#path.join */
   @:SinceClink("1.1.0")
   static function join(first:String, second:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.normalise */
   @:native("normalise")
   static function normalize(path:String, ?separator:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.toparent */
   @:SinceClink("1.2.0")
   @:native("toparent")
   static function toParent(path:String, ?separator:String):ToParentResult;
}

@:multiReturn
extern class ToParentResult {
   final parent:String;
   final child:String;
}
