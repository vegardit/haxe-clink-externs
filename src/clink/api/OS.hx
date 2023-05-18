/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import haxe.extern.EitherType;
import clink.api.IO.FileMode;
import clink.util.LuaArray;
import clink.util.LuaMap;

/**
 * https://chrisant996.github.io/clink/clink.html#os
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/os_api.cpp
 */
@:native("os")
extern class OS {
   /** https://chrisant996.github.io/clink/clink.html#os.abbreviatepath */
   @:native("abbreviatepath")
   static function abbreviatePath(path:String, ?decide:(path:String) -> Bool,
      ?transform:(name:String, isAbbreviated:Bool) -> Null<String>):String;

   /** https://chrisant996.github.io/clink/clink.html#os.chdir */
   static function chdir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.copy */
   static function copy(src:String, dest:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.createtmpfile */
   @:native("createtmpfile")
   static function createTmpFile(prefix:String = "tmp", ext:String = "", ?path:String,
      mode:FileMode = TEXT):ResultOrError<Null<CreateTempFileResult>>;

   /** https://chrisant996.github.io/clink/clink.html#os.debugprint */
   @:native("debugprint")
   static function debugPrint(anything:Dynamic):Void;

   /** https://chrisant996.github.io/clink/clink.html#os.expandabbreviatedpath */
   @:native("expandabbreviatedpath")
   static function expandAbbreviatedPath(path:String):Null<ExpandAbbreviatedPathResult>;

   /** https://chrisant996.github.io/clink/clink.html#os.expandenv */
   @:native("expandenv")
   static function expandEnv(value:String):String;

   /** https://chrisant996.github.io/clink/clink.html#os.getalias */
   @:native("getalias")
   static function getAlias(name:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getaliases */
   @:native("getaliases")
   static function getAliases():LuaMap<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getbatterystatus */
   @:native("getbatterystatus")
   static function getBatteryStatus():BatteryStatus;

   /** https://chrisant996.github.io/clink/clink.html#os.getclipboardtext */
   @:native("getclipboardtext")
   static function getClipboardText():Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getcwd
    * ```
    * >>> OS.getCWD().length > 0
    * ```
    */
   @:native("getcwd")
   static function getCWD():String;

   /** https://chrisant996.github.io/clink/clink.html#os.getdrivetype
    * ```
    * >>> OS.getDriveType() != null
    * ```
    */
   @:native("getdrivetype")
   static function getDriveType():DriveType;

   /** https://chrisant996.github.io/clink/clink.html#os.getenv */
   @:native("getenv")
   static function getEnv(value:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getenvnames */
   @:native("getenvnames")
   static function getEnvNames():LuaArray<EnvVar>;

   /** https://chrisant996.github.io/clink/clink.html#os.geterrorlevel
    * ```
    * >>> OS.getErrorLevel() == 0
    * ```
    */
   @:native("geterrorlevel")
   static function getErrorLevel():Int;

   /** https://chrisant996.github.io/clink/clink.html#os.getfileversion */
   @:native("getfileversion")
   static function getFileVersion(name:String):Null<FileVersion>;

   /** https://chrisant996.github.io/clink/clink.html#os.getfullpathname */
   @:native("getfullpathname")
   static function getFullPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.gethost
    * ```
    * >>> OS.getHost().length > 0
    * ```
    */
   @:native("gethost")
   static function getHost():String;

   /** https://chrisant996.github.io/clink/clink.html#os.getlongpathname */
   @:native("getlongpathname")
   static function getLongPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.getnetconnectionname */
   @:native("getnetconnectionname")
   static function getNetConnectionName(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.getpid
    * ```
    * >>> OS.getPID() > 0
    * ```
    */
   @:native("getpid")
   static function getPID():Int;

   /** https://chrisant996.github.io/clink/clink.html#os.getscreeninfo */
   @:native("getscreeninfo")
   static function getScreenInfo():ScreenInfo;

   /** https://chrisant996.github.io/clink/clink.html#os.getshortpathname */
   @:native("getshortpathname")
   static function getShortPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.gettemppath */
   @:native("gettemppath")
   static function getTempPath():ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globmatch
    * @since clink 1.4.24 */
   @:native("globmatch")
   overload static function globMatch(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globmatch
    * @since clink 1.4.24 */
   @:native("globmatch")
   overload static function globMatch(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, GlobFileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globdirs */
   @:native("globdirs")
   overload static function globDirs(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globdirs */
   @:native("globdirs")
   overload static function globDirs(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, GlobFileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globfiles */
   @:native("globfiles")
   overload static function globFiles(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globfiles */
   @:native("globfiles")
   overload static function globFiles(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, GlobFileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.isdir
    * ```
    * >>> OS.isDir('C:\\') == true
    * ```
    */
   @:native("isdir")
   static function isDir(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.isfile */
   @:native("isfile")
   static function isFile(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.issignaled */
   @:native("issignaled")
   static function isSignaled():Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.isuseradmin */
   @:native("isuseradmin")
   static function isUserAdmin():Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.mkdir */
   @:native("mkdir")
   static function mkDir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.move */
   static function move(src:String, dest:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.resolvealias */
   @:native("resolvealias")
   static function resolveAlias(text:String):Null<LuaArray<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.rmdir */
   @:native("rmdir")
   static function rmDir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.setclipboardtext */
   @:native("setclipboardtext")
   static function setClipboardText(text:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.setenv */
   @:native("setenv")
   static function setEnv(name:String, value:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.sleep */
   static function sleep(seconds:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#os.touch */
   static function touch(path:String, ?atime:Int, ?mtime:Int):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.unlink */
   static function unlink(path:String):ResultOrError<Bool>;
}

@:multiReturn extern class ResultOrError<T> {
   final result:T;
   final errorMessage:Null<String>;
   final errorNumber:Null<Int>;
}


/** https://chrisant996.github.io/clink/clink.html#os.createtmpfile */
typedef CreateTempFileResult = {
   handle:Any,
   name:String
}

/** https://chrisant996.github.io/clink/clink.html#os.globdirs
 * https://chrisant996.github.io/clink/clink.html#os.globfiles */
typedef GlobFilterOpts = {
   ?hidden:Bool,
   ?system:Bool
}

/** https://chrisant996.github.io/clink/clink.html#os.globdirs
 * https://chrisant996.github.io/clink/clink.html#os.globfiles */
typedef GlobFileInfo = {
   name:String,
   type:String,
   ?size:Int,
   ?atime:Int,
   ?mtime:Int,
   ?ctime:Int
}

/** https://chrisant996.github.io/clink/clink.html#os.getbatterystatus */
typedef BatteryStatus = {
   level:Int,
   acpower:Bool,
   charging:Bool,
   batterysaver:Bool
}

/** https://chrisant996.github.io/clink/clink.html#os.getdrivetype */
enum abstract DriveType(String) {
   final UNKNOWN = "unkown";
   final INVALID = "invalid";
   final REMOVABLE = "removable";
   final FIXED = "fixed";
   final RAMDISK = "ramdisk";
   final REMOTE = "remote";
}

/** https://chrisant996.github.io/clink/clink.html#os.getenv */
typedef EnvVar = {
   name:String,
   value:String
}

/** https://chrisant996.github.io/clink/clink.html#os.expandabbreviatedpath */
@:multiReturn
extern class ExpandAbbreviatedPathResult {
   final expandedPart:String;
   final remainingPart:String;
   final isFullyExpanded:Bool;
}

/** https://chrisant996.github.io/clink/clink.html#os.getfileversion */
typedef FileVersion = {
   filename:String,
   filevernum:String,
   productvernum:String,
   ?fileflags:FileFlags,
   osplatform:String,
   ?osqualifier:String,
   ?comments:String,
   companyname:String,
   filedescription:String,
   fileversion:String,
   internalname:String,
   ?legalcopyright:String,
   ?legaltrademarks:String,
   ?originalfilename:String,
   productname:String,
   productversion:String,
   ?privatebuild:String,
   ?specialbuild:String
}

/** https://chrisant996.github.io/clink/clink.html#os.getfileversion */
typedef FileFlags = {
   debug:String,
   prerelease:String,
   patched:String,
   privatebuild:String,
   specialbuild:String,
}

/** https://chrisant996.github.io/clink/clink.html#os.getscreeninfo */
typedef ScreenInfo = {
   bufwidth:Int,
   bufheight:Int,
   winwidth:Int,
   winheight:Int
}
