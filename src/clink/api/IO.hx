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
@:native("io")
extern class IO {
   /** https://chrisant996.github.io/clink/clink.html#io.open
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/io_api.cpp#L549 */
   static function open(filaname:String, ?mode:String):OpenResult;

   /** https://chrisant996.github.io/clink/clink.html#io.popenrw
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/io_api.cpp#L337 */
   static function popenrw(command:String, mode:FileMode = TEXT):PopenrwResult;

   /** https://chrisant996.github.io/clink/clink.html#io.truncate
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/io_api.cpp#L661 */
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
extern class TruncateResult {
   final success:Int;
   final errorMessage:Null<String>;
   final errorCode:Null<Int>;
}
