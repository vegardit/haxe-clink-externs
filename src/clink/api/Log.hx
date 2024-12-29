/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

/**
 * https://chrisant996.github.io/clink/clink.html#log
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/log_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("log")
extern class Log {
   /** https://chrisant996.github.io/clink/clink.html#log.getfile */
   @:SinceClink("1.4.15")
   @:native("getfile")
   static function getFile():Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#log.info */
   @:SinceClink("1.1.3")
   static function info(message:String, level:Int = 1):Void;
}
