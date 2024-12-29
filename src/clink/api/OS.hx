/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.internal.EitherType3;
import haxe.extern.EitherType;
import lua.NativeIterator;
import clink.api.IO.FileMode;
import clink.util.LuaArray;
import clink.util.LuaMap;

/**
 * https://chrisant996.github.io/clink/clink.html#os
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/os_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("os")
extern class OS {
   /** https://chrisant996.github.io/clink/clink.html#os.abbreviatepath
    * ```
    * >>> OS.abbreviatePath("C:\\Windows\\System32\\Dism") == "C:\\Windows\\System3\\Dism"
    * ```
    */
   @:SinceClink("1.4.1")
   @:native("abbreviatepath")
   static function abbreviatePath(path:String, ?decide:(path:String) -> Bool,
      ?transform:(name:String, isAbbreviated:Bool) -> Null<String>):String;

   /** https://chrisant996.github.io/clink/clink.html#os.chdir */
   @:SinceClink("1.0.0")
   static function chdir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.clock
    * ```
    * >>> OS.clock() > 0
    * ```
    */
   @:SinceClink("1.2.30")
   static function clock():Float;

   /** https://chrisant996.github.io/clink/clink.html#os.copy */
   @:SinceClink("1.2.30")
   static function copy(src:String, dest:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.createguid
    * ```
    * >>> OS.createGuid()    .guid.length == 36
    * >>> OS.createGuid(true).guid.length == 36
    * ```
    */
   @:SinceClink("1.7.0")
   @:native("createguid")
   static function createGuid(?faster:Bool):Null<CreateGuidResult>;

   /** https://chrisant996.github.io/clink/clink.html#os.createtmpfile */
   @:SinceClink("1.1.42")
   @:native("createtmpfile")
   static function createTmpFile(prefix:String = "tmp", ext:String = "", ?path:String,
      mode:FileMode = TEXT):ResultOrError<Null<CreateTempFileResult>>;

   /** https://chrisant996.github.io/clink/clink.html#os.debugprint */
   @:SinceClink("1.2.20")
   @:native("debugprint")
   static function debugPrint(anything:Dynamic):Void;

   /** https://chrisant996.github.io/clink/clink.html#os.enumshares */
   @:SinceClink("1.6.0")
   @:native("enumshares")
   static function enumerateShares(server:String, hidden:Bool = false, timeout:Float = 0):NativeIterator<EitherType3<Bool, String, ShareInfoStatus>>;

   /** https://chrisant996.github.io/clink/clink.html#os.expandabbreviatedpath */
   @:SinceClink("1.4.1")
   @:native("expandabbreviatedpath")
   static function expandAbbreviatedPath(path:String):Null<ExpandAbbreviatedPathResult>;

   /** https://chrisant996.github.io/clink/clink.html#os.expandenv */
   @:SinceClink("1.2.5")
   @:native("expandenv")
   static function expandEnv(value:String):String;

   /** https://chrisant996.github.io/clink/clink.html#os.findfiles */
   @:SinceClink("1.6.13")
   @:native("findfiles")
   static function findFiles(pattern:String, ?extraInfo:EitherType<Bool, Int>, ?flags:FindFilesOpts):FindFilesResult;

   /** https://chrisant996.github.io/clink/clink.html#os.getalias */
   @:SinceClink("1.1.4")
   @:native("getalias")
   static function getAlias(name:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getaliases */
   @:SinceClink("1.1.7")
   @:native("getaliases")
   static function getAliases():LuaMap<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getbatterystatus */
   @:SinceClink("1.1.17")
   @:native("getbatterystatus")
   static function getBatteryStatus():BatteryStatus;

   /** https://chrisant996.github.io/clink/clink.html#os.getclipboardtext */
   @:SinceClink("1.2.32")
   @:native("getclipboardtext")
   static function getClipboardText():Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getcwd
    * ```
    * >>> OS.getCWD().length > 0
    * ```
    */
   @:SinceClink("1.0.0")
   @:native("getcwd")
   static function getCWD():String;

   /** https://chrisant996.github.io/clink/clink.html#os.getdrivetype
    * ```
    * >>> OS.getDriveType() != null
    * ```
    */
   @:SinceClink("1.3.37")
   @:native("getdrivetype")
   static function getDriveType():DriveType;

   /** https://chrisant996.github.io/clink/clink.html#os.getenv */
   @:SinceClink("1.0.0")
   @:native("getenv")
   static function getEnv(value:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.getenvnames */
   @:SinceClink("1.0.0")
   @:native("getenvnames")
   static function getEnvNames():LuaArray<EnvVar>;

   /** https://chrisant996.github.io/clink/clink.html#os.geterrorlevel
    * ```
    * >>> OS.getErrorLevel() == 0
    * ```
    */
   @:SinceClink("1.2.14")
   @:native("geterrorlevel")
   static function getErrorLevel():Int;

   /** https://chrisant996.github.io/clink/clink.html#os.getfileversion */
   @:SinceClink("1.4.17")
   @:native("getfileversion")
   static function getFileVersion(name:String):Null<FileVersion>;

   /** https://chrisant996.github.io/clink/clink.html#os.getfullpathname */
   @:SinceClink("1.1.42")
   @:native("getfullpathname")
   static function getFullPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.gethost
    * ```
    * >>> OS.getHost().length > 0
    * ```
    */
   @:SinceClink("1.0.0")
   @:native("gethost")
   static function getHost():String;

   /** https://chrisant996.github.io/clink/clink.html#os.getlongpathname */
   @:SinceClink("1.1.42")
   @:native("getlongpathname")
   static function getLongPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.getnetconnectionname */
   @:SinceClink("1.2.27")
   @:native("getnetconnectionname")
   static function getNetConnectionName(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.getpid
    * ```
    * >>> OS.getPID() > 0
    * ```
    */
   @:SinceClink("1.1.41")
   @:native("getpid")
   static function getPID():Int;

   /** https://chrisant996.github.io/clink/clink.html#os.getpushddepth */
   @:SinceClink("1.5.6")
   @:native("getpushddepth")
   static function getPushdDepth():GetPushdDepthResult;

   /** https://chrisant996.github.io/clink/clink.html#os.getscreeninfo */
   @:SinceClink("1.1.2")
   @:native("getscreeninfo")
   static function getScreenInfo():ScreenInfo;

   /** https://chrisant996.github.io/clink/clink.html#os.getshortpathname */
   @:SinceClink("1.1.42")
   @:native("getshortpathname")
   static function getShortPath(path:String):ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.gettemppath */
   @:SinceClink("1.3.18")
   @:native("gettemppath")
   static function getTempPath():ResultOrError<Null<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globdirs */
   @:SinceClink("1.0.0")
   @:native("globdirs")
   overload static function globDirs(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globdirs */
   @:SinceClink("1.0.0")
   @:native("globdirs")
   overload static function globDirs(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, FileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globfiles */
   @:SinceClink("1.0.0")
   @:native("globfiles")
   overload static function globFiles(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globfiles */
   @:SinceClink("1.0.0")
   @:native("globfiles")
   overload static function globFiles(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, FileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.globmatch */
   @:SinceClink("1.4.24")
   @:native("globmatch")
   overload static function globMatch(pattern:String):LuaArray<String>;

   /** https://chrisant996.github.io/clink/clink.html#os.globmatch */
   @:SinceClink("1.4.24")
   @:native("globmatch")
   overload static function globMatch(pattern:String, ?extraInfo:EitherType<Bool, Int>,
      ?filter:GlobFilterOpts):LuaArray<EitherType<String, FileInfo>>;

   /** https://chrisant996.github.io/clink/clink.html#os.isdir
    * ```
    * >>> OS.isDir('C:\\') == true
    * ```
    */
   @:SinceClink("1.0.0")
   @:native("isdir")
   static function isDir(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.isfile */
   @:SinceClink("1.0.0")
   @:native("isfile")
   static function isFile(path:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.issignaled */
   @:SinceClink("1.3.14")
   @:native("issignaled")
   static function isSignaled():Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.isuseradmin */
   @:SinceClink("1.4.17")
   @:native("isuseradmin")
   static function isUserAdmin():Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.mkdir */
   @:SinceClink("1.0.0")
   @:native("mkdir")
   static function mkDir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.move */
   @:SinceClink("1.0.0")
   static function move(src:String, dest:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.resolvealias */
   @:SinceClink("1.3.12")
   @:native("resolvealias")
   static function resolveAlias(text:String):Null<LuaArray<String>>;

   /** https://chrisant996.github.io/clink/clink.html#os.rmdir */
   @:SinceClink("1.0.0")
   @:native("rmdir")
   static function rmDir(path:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.setalias */
   @:native("setalias")
   @:SinceClink("1.6.11")
   static function setAlias(name:String, command:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.setclipboardtext */
   @:native("setclipboardtext")
   @:SinceClink("1.2.32")
   static function setClipboardText(text:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#os.setenv */
   @:SinceClink("1.0.0")
   @:native("setenv")
   static function setEnv(name:String, value:String):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.sleep */
   @:SinceClink("1.3.16")
   static function sleep(seconds:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#os.touch */
   @:SinceClink("1.2.31")
   static function touch(path:String, ?atime:Int, ?mtime:Int):ResultOrError<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#os.unlink */
   @:SinceClink("1.0.0")
   static function unlink(path:String):ResultOrError<Bool>;
}

@:multiReturn extern class ResultOrError<T> {
   final result:T;
   final errorMessage:Null<String>;
   final errorNumber:Null<Int>;
}


/** https://chrisant996.github.io/clink/clink.html#rl.createguid */
@:multiReturn
extern class CreateGuidResult {
   final guid:String;
   final isOnlyLocallyUnique:Bool;
}

/** https://chrisant996.github.io/clink/clink.html#os.createtmpfile */
typedef CreateTempFileResult = {
   handle:Any,
   name:String
}

enum abstract ShareInfoStatus(String) to String {
   final CANCELED = "canceled";
}


/** https://chrisant996.github.io/clink/clink.html#os.findfiles */
typedef FindFilesOpts = {
   ?files:Bool,
   ?dirs:Bool,
   ?hidden:Bool,
   ?system:Bool,
   ?dirsuffix:Bool
}

extern class FindFilesResult {
   function next():Null<EitherType<String, FileInfo>>;
   function files():NativeIterator<EitherType<String, FileInfo>>;
   function close():Void;
}


/** https://chrisant996.github.io/clink/clink.html#os.globdirs
 * https://chrisant996.github.io/clink/clink.html#os.globfiles */
typedef GlobFilterOpts = {
   ?hidden:Bool,
   ?system:Bool
}

/** https://chrisant996.github.io/clink/clink.html#os.globdirs
 * https://chrisant996.github.io/clink/clink.html#os.globfiles */
typedef FileInfo = {
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

/** https://chrisant996.github.io/clink/clink.html#rl.getpushddepth */
@:multiReturn
extern class GetPushdDepthResult {
   final depth:Int;
   final isDepthKnown:Bool;
}

/** https://chrisant996.github.io/clink/clink.html#os.getscreeninfo */
typedef ScreenInfo = {
   bufwidth:Int,
   bufheight:Int,
   winwidth:Int,
   winheight:Int
}
