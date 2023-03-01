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
@:native("path")
extern class Path {
   /** https://chrisant996.github.io/clink/clink.html#path.getbasename
    * ```
    * >>> Path.getBaseName("foo\\bar") == "bar"
    * ```
    */
   @:native("getbasename")
   static function getBaseName(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.getdirectory
    * ```
    * >>> Path.getDirectory("foo\\bar") == "foo"
    * ```
    */
   @:native("getdirectory")
   static function getDirectory(path:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#path.getdrive
    * ```
    * >>> Path.getDrive("C:\\foo\\bar") == "C:"
    * >>> Path.getDrive("foo\\bar") == null
    * ```
    */
   @:native("getdrive")
   static function getDrive(path:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#path.getextension
    * ```
    * >>> Path.getExtension("C:\\foo\\bar.txt") == ".txt"
    * >>> Path.getExtension("C:\\foo\\bar") == ""
    * ```
    */
   @:native("getextension")
   static function getExtension(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.getname
    * ```
    * >>> Path.getExtension("C:\\foo\\bar.txt") == ".txt"
    * >>> Path.getExtension("C:\\foo\\bar") == ""
    * ```
    */
   @:native("getname")
   static function getName(path:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.isexecext */
   @:native("isexecext")
   static function isExecExt(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#path.join */
   static function join(first:String, second:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.normalise */
   @:native("normalise")
   static function normalize(path:String, ?separator:String):String;

   /** https://chrisant996.github.io/clink/clink.html#path.toparent */
   @:native("toparent")
   static function toParent(path:String, ?separator:String):ToParentResult;
}

@:multiReturn
extern class ToParentResult {
   final parent:String;
   final child:String;
}
