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
@:native("rl")
extern class RL {
   /** https://chrisant996.github.io/clink/clink.html#rl.collapsetilde */
   @:native("collapsetilde")
   static function collapseTilde(path:String, ?force:Bool):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.describemacro */
   @:native("describemacro")
   static function describeMacro(macroString:String, description:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#rl.expandtilde */
   @:native("expandtilde")
   static function expandTilde(path:String, ?wholeLine:Bool):ExpandTildeResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.getbinding */
   @:native("getbinding")
   static function getBinding(key:String, ?keymap:String):GetBindingResult;

   /** https://chrisant996.github.io/clink/clink.html#rl.gethistorycount */
   @:native("gethistorycount")
   static function getHistoryCount():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl.gethistoryitems */
   @:native("gethistoryitems")
   static function getHistoryItems():Int;

   /** https://chrisant996.github.io/clink/clink.html#rl.getkeybindings */
   @:native("getkeybindings")
   static function getKeyBindings(raw:Bool, mode:Int):LuaArray<KeyBinding>;

   /** https://chrisant996.github.io/clink/clink.html#rl.getlastcommand */
   @:native("getlastcommand")
   static function getLastCommand():String;

   /** https://chrisant996.github.io/clink/clink.html#rl.getmatchcolor */
   @:native("getmatchcolor")
   overload static function getMatchColor(match:String, ?type:String):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.getmatchcolor */
   @:native("getmatchcolor")
   overload static function getMatchColor(match:Match):String;

   /** https://chrisant996.github.io/clink/clink.html#rl.getpromptinfo */
   @:native("getpromptinfo")
   static function getPromptInfo():PromptInfo;

   /** https://chrisant996.github.io/clink/clink.html#rl.getvariable */
   @:native("getvariable")
   static function getVariable(name:String):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#rl.insertmode */
   @:native("insertmode")
   static function insertMode(?insert:Bool):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.invokecommand */
   @:native("invokecommand")
   static function invokeCommand(command:String, ?count:Int):Null<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#rl.islineequal */
   @:native("islineequal")
   static function isLineEqual(text:String, ?toCursor:Bool):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.ismodifiedline */
   @:native("ismodifiedline")
   static function isModifiedLine():Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.isvariabletrue */
   @:native("isvariabletrue")
   static function isVariableTrue(name:String):Null<Bool>;

   /** https://chrisant996.github.io/clink/clink.html#rl.isvariabletrue */
   @:native("needquotes")
   static function needQuotes(text:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setbinding */
   @:native("setbinding")
   static function setBinding(key:String, binding:Null<String>, ?keymap:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setmatches */
   @:native("setmatches")
   static function setMatches(matches:SetMatchesArray, ?type:String):Bool;

   /** https://chrisant996.github.io/clink/clink.html#rl.setvariable */
   @:native("setvariable")
   static function setVariable(name:String, value:String):Bool;
}

function foo() {
   new LuaArray<String>();
   var m = SetMatchesArray.fromArray([{match: "ff"}]);
   m.nosort = true;
   RL.setMatches(m);
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
