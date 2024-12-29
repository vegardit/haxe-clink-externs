/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import lua.FileHandle;

/** 
 * https://chrisant996.github.io/clink/clink.html#io
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/io_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("io")
extern class IO {
   /** https://chrisant996.github.io/clink/clink.html#io.open */
   @:SinceClink("0.0.1")
   static function open(filaname:String, mode:String = "r"):OpenResult;

   /** https://chrisant996.github.io/clink/clink.html#io.popenrw */
   @:SinceClink("1.1.42")
   static function popenrw(command:String, mode:FileMode = TEXT):PopenrwResult;

   /** https://chrisant996.github.io/clink/clink.html#io.popenrw */
   @:SinceClink("1.2.10")
   static function popenyield(command:String, mode:FileMode = TEXT):PopenyieldResult;

   /** https://chrisant996.github.io/clink/clink.html#io.sopen */
   @:SinceClink("1.3.18")
   static function sopen(filename:String, mode:String = "r", deny:String = ""):PopenyieldResult;

   /** https://chrisant996.github.io/clink/clink.html#io.truncate */
   @:SinceClink("1.3.41")
   static function truncate(file:FileHandle):TruncateResult;
}

/** https://chrisant996.github.io/clink/clink.html#os.createtmpfile
 * https://chrisant996.github.io/clink/clink.html#io.open */
enum abstract FileMode(String) {
   final BINARY = "b";
   final TEXT = "t";
}

@:multiReturn
extern class OpenResult {
   final fileHandle:Null<FileHandle>;
   final errorMessage:Null<String>;
   final errorCode:Null<Int>;
}


@:multiReturn
extern class PopenrwResult {
   final stdout:FileHandle;
   final stdint:FileHandle;
}


@:multiReturn
extern class PopenyieldResult {
   final stdout:FileHandle;

   @:SinceClink("1.3.31")
   final close:Void->Int;
}


@:multiReturn
extern class TruncateResult {
   final success:Int;
   final errorMessage:Null<String>;
   final errorCode:Null<Int>;
}
