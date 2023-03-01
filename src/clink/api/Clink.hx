/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import haxe.Constraints.Function;
import lua.Coroutine;
import clink.api.MatchBuilder.Match;
import clink.api.MatchBuilder.Matches;
import clink.api.MatchBuilder.MatchTypeWithModifiers;
import clink.util.LuaArray;

/**
 * https://chrisant996.github.io/clink/clink.html#clink
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/clink_api.cpp
 * https://github.com/chrisant996/clink/blob/master/clink/lua/scripts/arguments.lua
 * https://github.com/chrisant996/clink/blob/master/clink/lua/scripts/events.lua
 * https://github.com/chrisant996/clink/blob/master/clink/lua/scripts/generator.lua
 */
@:forwardStatics
abstract Clink(ClinkExtern) from ClinkExtern {

   /** https://chrisant996.github.io/clink/clink.html#clink.argmatcher */
   public inline static function argMatcher(...commands:String):ArgMatcher {
      #if haxe_doctest
         // workaround for "attempt to call field 'argmatcher' (a nil value)"
         // when running via the Clink embedded lua interpreter ArgMatcher is not available
         return cast {
            nofiles: () -> {
            }
         };
      #else
         return ClinkExtern._argmatcher(999, ...commands);
      #end
   }

   /** https://chrisant996.github.io/clink/clink.html#clink.argmatcher */
   public inline static function argMatcherWithPriority(priority:Int, ...commands:String):ArgMatcher {
      return ClinkExtern._argmatcher(priority, ...commands);
   }
}

@:allow(clink.api.Clink)
@:native("clink")
private extern class ClinkExtern {
   /** https://chrisant996.github.io/clink/clink.html#clink.argmatcher
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1714 */
   @:native("argmatcher")
   private static function _argmatcher(priority:Int, ...commands:String):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#clink.dirmatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1785 */
   @:native("dirmatches")
   static function dirMatches(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.filematches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1822 */
   @:native("filematches")
   static function fileMatches(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.generator
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/generator.lua#L321 */
   static function generator(?priority:Int):MatchGenerator;

   /** https://chrisant996.github.io/clink/clink.html#clink.getansihost
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L807 */
   @:native("getansihost")
   static function getAnsiHost():String;

   /** https://chrisant996.github.io/clink/clink.html#clink.getargmatcher
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L2183 */
   @:native("getargmatcher")
   overload static function getArgMatcher(command:String):Null<ArgMatcher>;

   @:native("getargmatcher")
   overload static function getArgMatcher(lineState:LineState):Null<ArgMatcher>;

   /** https://chrisant996.github.io/clink/clink.html#clink.getpopuplistcolors
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L746 */
   @:native("getpopuplistcolors")
   static function getPopupListColors():PopupColors;

   /** https://chrisant996.github.io/clink/clink.html#clink.getsession
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L784 */
   @:native("getsession")
   static function getSession():String;

   /** https://chrisant996.github.io/clink/clink.html#clink.onaftercommand
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L359 */
   @:native("onaftercommand")
   static function onAfterCommand(func:() -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onbeginedit
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L146 */
   @:native("onbeginedit")
   static function onBeginEdit(func:() -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oncommand
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L229 */
   @:native("oncommand")
   static function onCommand(func:(lineState:LineState, commandInfo:{
      command:String,
      quoted:Bool,
      type:String,
      file:String
   }) -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.ondisplaymatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L250 */
   @:native("ondisplaymatches")
   static function onDisplayMatches(func:(matches:LuaArray<Match>, popup:Bool) -> LuaArray<Match>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onendedit
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L192 */
   @:native("onendedit")
   static function onEndEdit(func:(line:String) -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onfilterinput
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L207 */
   @:native("onfilterinput")
   static function onFilterInput(func:(line:String) -> OnFilterInputResult):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onfiltermatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L302 */
   @:native("onfiltermatches")
   static function onFilterMatches(func:(matches:LuaArray<Match>, completionType:CompletionType,
      filenameCompletionDesired:Bool) -> LuaArray<Match>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oninject
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L136 */
   @:native("oninject")
   static function onInject(func:() -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oninputlinechanged
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L313 */
   @:native("oninputlinechanged")
   static function onInputLineChanged(func:(line:String) -> Void):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onprovideline
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L313 */
   @:native("onprovideline")
   static function onProvideLine(func:(line:String) -> Null<String>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.parseline */
   @:native("parseline")
   static function parseLine(line:String):LuaArray<LineState>;

   /** https://chrisant996.github.io/clink/clink.html#clink.popuplist
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L465 */
   @:native("popuplist")
   static function popupList(title:String, items:LuaArray<{value:String, ?display:String, ?description:String}>, ?index:Int,
      ?del_callback:(index:Int) -> Bool):Null<PopupListResult>;

   /** https://chrisant996.github.io/clink/clink.html#clink.print
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L63 */
   static function print(...values:Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.promptcoroutine */
   @:native("promptcoroutine")
   static function promptCoroutine<T>(func:() -> T):Null<T>;

   /** https://chrisant996.github.io/clink/clink.html#clink.promptfilter */
   @:native("promptfilter")
   static function promptFilter(?priority:Int):PromptFilter;

   /** https://chrisant996.github.io/clink/clink.html#clink.reclassifyline */
   @:native("reclassifyline")
   static function reclassifyLine():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.recognizecommand */
   @:native("recognizecommand")
   overload static function recognizeCommand(line:String, word:String, ?quoted:Bool):RecognizeCommandResult;

   @:native("recognizecommand")
   overload static function recognizeCommand(word:String, ?quoted:Bool):RecognizeCommandResult;

   /** https://chrisant996.github.io/clink/clink.html#clink.refilterafterterminalresize */
   @:native("refilterafterterminalresize")
   static function refilterAfterTerminalResize(refilter:Bool):Bool;

   /** https://chrisant996.github.io/clink/clink.html#clink.refilterprompt
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L975 */
   @:native("refilterPrompt")
   static function refilterprompt():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.reload
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L951 */
   static function reload():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.runcoroutineuntilcomplete */
   @:native("runcoroutineuntilcomplete")
   static function runCoroutineUntilComplete(corountine:Coroutine<Function>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.setcoroutineinterval */
   @:native("setcoroutineinterval")
   static function setCoroutineInterval(corountine:Coroutine<Function>, ?interval:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.setcoroutinename */
   @:native("setcoroutinename")
   static function setCoroutineName(corountine:Coroutine<Function>, name:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.suggester
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/app/scripts/suggest.lua#L126
    * >>> Clink.suggester("somename") != null
    */
   static function suggester(name:String):Suggester;

   /** https://chrisant996.github.io/clink/clink.html#clink.translateslashes
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L858 */
   @:native("translateslashes")
   static function translateSlashes(?mode:SlashTranslation):Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_commit */
   @:native("version_commit")
   static final versionCommit:String;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_encoded */
   @:native("version_encoded")
   static final versionEncoded:String;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_major */
   @:native("version_major")
   static final versionMajor:Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_minor */
   @:native("version_minor")
   static final versionMinor:Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_patch */
   @:native("version_patch")
   static final versionPatch:Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.lower
    * ```
    * >>> Clink.lower("Äpfel") == "äpfel"
    * ```
    */
   @:allow(clink.TestRunner)
   @:allow(clink.util.Strings)
   private static function lower(text:String):String;

   /** https://chrisant996.github.io/clink/clink.html#clink.upper
    * ```
    * >>> Clink.upper("äpfel") == "ÄPFEL"
    * ```
    */
   @:allow(clink.TestRunner)
   @:allow(clink.util.Strings)
   private static function upper(text:String):String;
}


/** https://chrisant996.github.io/clink/clink.html#filteringmatchcompletions */
enum abstract CompletionType(String) to String {
   final LIST_COMPLETIONS = "?";
   final INSERT_COMPLETIONS = "*";
   final COMPLETE = "\t";
   final COMPLETE_AND_SHOW_ALL_IF_AMBIGUOUS = "!";
   final COMPLETE_AND_SHOW_ALL_IF_UNMODIFIED = "@";
   final MENU_COMPLETE = "%";
}

@:forward
abstract FileMatch(FileMatchExtern) from FileMatchExtern to FileMatchExtern {

   public var path(get, never):String;
   public var isDir(get, never):Bool;
   public var isFile(get, never):Bool;
   public var isHidden(get, never):Bool;
   public var isLink(get, never):Bool;
   public var isOrphaned(get, never):Bool;
   public var isReadOnly(get, never):Bool;

   inline function get_path():String
      return this.match;

   inline function get_isDir():Bool
      return this.type.type == DIR;

   inline function get_isFile():Bool
      return this.type.type == FILE;

   inline function get_isHidden():Bool
      return this.type.hasModifier(HIDDEN);

   inline function get_isLink():Bool
      return this.type.hasModifier(LINK);

   inline function get_isOrphaned():Bool
      return this.type.hasModifier(ORPHANED);

   inline function get_isReadOnly():Bool
      return this.type.hasModifier(READONLY);
}


private typedef FileMatchExtern = {
   type:MatchTypeWithModifiers
} &
   Match;


/** https://chrisant996.github.io/clink/clink.html#matchgenerators */
interface MatchGenerator {
   dynamic function generate(lineState:LineState, matchBuilder:MatchBuilder):Void;
}

/** https://chrisant996.github.io/clink/clink.html#clink.onfilterinput */
@:multiReturn
extern class OnFilterInputResult {
   final replacement:Null<String>;
   final continueFiltering:Null<Bool>;
}

/** https://chrisant996.github.io/clink/clink.html#clink.popuplist */
@:multiReturn
extern class PopupListResult {
   final value:String;
   final multiSelect:Bool;
   final itemsIndex:Int;
}

/** https://chrisant996.github.io/clink/clink.html#clink.getpopuplistcolors */
typedef PopupColors = {
   items:String,
   desc:String
}

/** https://chrisant996.github.io/clink/clink.html#clink.promptfilter */
interface PromptFilter {
   dynamic function filter(prompt:String):String;
}

/** https://chrisant996.github.io/clink/clink.html#clink.recognizecommand */
@:multiReturn
extern class RecognizeCommandResult {
   final word_class:String;
   final ready:Bool;
   final file:String;
}

/** https://chrisant996.github.io/clink/clink.html#clink.translateslashes */
enum abstract SlashTranslation(Int) to Int {
   final NONE = 0;
   final TO_SYSTEM_PATH_SEPARATOR = 1;
   final TO_SLASH = 2;
   final TO_BACKSLASH = 3;
}

/** https://chrisant996.github.io/clink/clink.html#clink.suggester */
interface Suggester {
   dynamic function suggest(lineState:LineState, matches:Matches):String;
}
