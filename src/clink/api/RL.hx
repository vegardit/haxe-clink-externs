/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.api.MatchBuilder.Match;
import clink.util.LuaArray;

/**
 * https://chrisant996.github.io/clink/clink.html#rl
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/rl_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("rl")
extern class RL {
   /** https://chrisant996.github.io/clink/clink.html#rl.bracketpromptcodes */
   @:SinceClink("1.6.1")
   @:native("bracketpromptcodes ")
   static function bracketPromptCodes(prompt:String):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.collapsetilde */
   @:SinceClink("1.1.6")
   @:native("collapsetilde")
   static function collapseTilde(path:String, force:Bool = false):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.describemacro */
   @:SinceClink("1.3.41")
   @:native("describemacro")
   static function describeMacro(macroString:String, description:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl.expandtilde */
   @:SinceClink("1.1.6")
   @:native("expandtilde")
   static function expandTilde(path:String, wholeLine:Bool = false):ExpandTildeResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.getbinding */
   @:SinceClink("1.2.46")
   @:native("getbinding")
   static function getBinding(key:String, ?keymap:String):GetBindingResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.getcommandbindings */
   @:SinceClink("1.5.1")
   @:native("getcommandbindings")
   static function getCommandBindings(command:String, raw:Bool):Null<CommandBindings>;

   /** https://chrisant996.github.io/clink/clink.html#rl.gethistorycount */
   @:SinceClink("1.3.18")
   @:native("gethistorycount")
   static function getHistoryCount():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl.gethistoryitems */
   @:SinceClink("1.3.18")
   @:native("gethistoryitems")
   static function getHistoryItems():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl.getinputrcfilename */
   @:SinceClink("1.6.1")
   @:native("getinputrcfilename")
   static function getInputrcFilename():GetInputrcFilenameResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.getkeybindings */
   @:SinceClink("1.2.16")
   @:native("getkeybindings")
   static function getKeyBindings(raw:Bool, mode:Int = 0):LuaArray<KeyBinding>;

   /** https://chrisant996.github.io/clink/clink.html#rl.getlastcommand */
   @:SinceClink("1.1.40")
   @:native("getlastcommand")
   static function getLastCommand():GetLastCommandResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.getmatchcolor */
   @:SinceClink("1.3.4")
   @:native("getmatchcolor")
   overload static function getMatchColor(match:String, ?type:String):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.getmatchcolor */
   @:SinceClink("1.3.4")
   @:native("getmatchcolor")
   overload static function getMatchColor(match:Match):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.getpromptinfo */
   @:SinceClink("1.2.28")
   @:native("getpromptinfo")
   static function getPromptInfo():PromptInfo;

   /** https://chrisant996.github.io/clink/clink.html#rl.getvariable */
   @:SinceClink("1.1.6")
   @:native("getvariable")
   static function getVariable(name:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#rl.insertmode */
   @:SinceClink("1.2.50")
   @:native("insertmode")
   static function insertMode(?insert:Bool):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.invokecommand */
   @:SinceClink("1.1.26")
   @:native("invokecommand")
   static function invokeCommand(command:String, count:Int = 1):Null<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#rl.islineequal */
   @:SinceClink("1.4.14")
   @:native("islineequal")
   static function isLineEqual(text:String, toCursor:Bool = false):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.ismodifiedline */
   @:SinceClink("1.2.51")
   @:native("ismodifiedline")
   static function isModifiedLine():Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.isvariabletrue */
   @:SinceClink("1.1.6")
   @:native("isvariabletrue")
   static function isVariableTrue(name:String):Null<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#rl.isvariabletrue */
   @:SinceClink("1.4.8")
   @:native("needquotes")
   static function needQuotes(text:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setbinding */
   @:SinceClink("1.2.46")
   @:native("setbinding")
   static function setBinding(key:String, binding:Null<String>, ?keymap:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setmatches */
   @:SinceClink("1.1.40")
   @:native("setmatches")
   static function setMatches(matches:SetMatchesArray, ?type:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setvariable */
   @:SinceClink("1.1.46")
   @:native("setvariable")
   static function setVariable(name:String, value:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.translatekey */
   @:SinceClink("1.1.46")
   @:native("translatekey")
   static function translateKey(input:String, form:TranslateKeyFormat):Null<String>;
}

/** https://chrisant996.github.io/clink/clink.html#rl.setmatches */
@:forward
abstract SetMatchesArray(LuaArray<Match>) from LuaArray<Match> to LuaArray<Match> {

   @:from
   inline public static function fromArray(arr:Array<Match>):SetMatchesArray {
      return LuaArray.fromArray(arr);
   }

   public function new() {
      this = new LuaArray<Match>();
   }

   public var nosort(get, set):Null<Bool>;

   inline function get_nosort():Null<Bool> {
      return (cast this).nosort;
   }

   inline function set_nosort(value:Null<Bool>):Null<Bool> {
      (cast this).nosort = value;
      return value;
   }
}

/** https://chrisant996.github.io/clink/clink.html#rl.getcommandbindings */
typedef CommandBindings = {
   desc:String,
   category:String,
   keys:LuaArray<String>
}

/** https://chrisant996.github.io/clink/clink.html#rl.expandtilde */
@:multiReturn
extern class ExpandTildeResult {
   final word:String;
   final expanded:String;
}

/** https://chrisant996.github.io/clink/clink.html#rl.getbinding */
@:multiReturn
extern class GetBindingResult {
   final binding:String;
   final type:String;
}

/** https://chrisant996.github.io/clink/clink.html#rl.getinputrcfilename */
@:multiReturn
extern class GetInputrcFilenameResult {
   var path:Null<String>;
   var filename:Null<String>;
}

/** https://chrisant996.github.io/clink/clink.html#rl.getlastcommand */
@:multiReturn
extern class GetLastCommandResult {
   var command:String;
   var luaFunctionName:String;
}

/** https://chrisant996.github.io/clink/clink.html#rl.getkeybindings */
typedef KeyBinding = {
   key:String,
   binding:String,
   desc:String,
   category:String
}

/** https://chrisant996.github.io/clink/clink.html#rl.getpromptinfo */
typedef PromptInfo = {
   promptprefix:String,
   promptprefixlinecount:Int,
   prompt:String,
   ?rprompt:String,
   promptline:Int,
   inputline:Int,
   inputlinecount:Int
}

/** https://chrisant996.github.io/clink/clink.html#rl.translatekey */
enum abstract TranslateKeyFormat(Int) to Int {
   final InputSeqToReadableName = 1;
   final InputSeqToBindableSeq = 2;
   final BindingSeqToReadableName = 3;
   final BindingSeqToInputSeq = 4;
}
