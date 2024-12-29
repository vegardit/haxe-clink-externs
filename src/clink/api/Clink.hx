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
@:ClinkAPI("1.7.7")
private extern class ClinkExtern {
   /** https://chrisant996.github.io/clink/clink.html#clink.applytheme */
   @:SinceClink("1.7.0")
   @:native("applytheme")
   static function applyTheme(theme:String, clearAll:Bool = false, noSave:Bool = false): /* TODO */ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.argmatcher
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1714 */
   @:SinceClink("1.0.0")
   @:native("argmatcher")
   private static function _argmatcher(priority:Int, ...commands:String):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#clink.classifier */
   @:SinceClink("1.1.49")
   static function classifier(?priority:Int): /* TODO */ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.dirmatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1785 */
   @:SinceClink("1.1.8")
   @:native("dirmatches")
   static function dirMatches(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.dirmatchesexact */
   @:SinceClink("1.6.4")
   @:native("dirmatchesexact")
   static function dirMatchesExact(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.filematches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1822 */
   @:SinceClink("1.1.8")
   @:native("filematches")
   static function fileMatches(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.filematchesexact */
   @:SinceClink("1.6.4")
   @:native("filematchesexact")
   static function fileMatchesExact(matchWord:String):LuaArray<FileMatch>;

   /** https://chrisant996.github.io/clink/clink.html#clink.generator
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/generator.lua#L321 */
   @:SinceClink("1.0.0")
   static function generator(?priority:Int):MatchGenerator;

   /** https://chrisant996.github.io/clink/clink.html#clink.getansihost
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L807 */
   @:SinceClink("1.1.48")
   @:native("getansihost")
   static function getAnsiHost():String;

   /** https://chrisant996.github.io/clink/clink.html#clink.getargmatcher
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L2183 */
   @:SinceClink("1.3.12")
   @:native("getargmatcher")
   overload static function getArgMatcher(command:String):Null<ArgMatcher>;

   @:SinceClink("1.3.12")
   @:native("getargmatcher")
   overload static function getArgMatcher(lineState:LineState):Null<ArgMatcher>;

   /** https://chrisant996.github.io/clink/clink.html#clink.getclinkprompt */
   @:SinceClink("1.7.0")
   @:native("getclinkprompt")
   function getClinkPrompt(): /*TODO*/ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.getpopuplistcolors
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L746 */
   @:SinceClink("1.4.0")
   @:native("getpopuplistcolors")
   static function getPopupListColors():PopupColors;

   /** https://chrisant996.github.io/clink/clink.html#clink.getprompts */
   @:SinceClink("1.7.0")
   @:native("getprompts")
   overload function getPrompts(): /*TODO*/ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.getprompts */
   @:SinceClink("1.7.0")
   @:native("getprompts")
   overload function getPrompts(name:String):String;

   /** https://chrisant996.github.io/clink/clink.html#clink.getsession
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L784 */
   @:SinceClink("1.4.44")
   @:native("getsession")
   static function getSession():String;

   /** https://chrisant996.github.io/clink/clink.html#clink.getthemes */
   @:SinceClink("1.7.0")
   @:native("getthemes")
   overload function getThemes(): /*TODO*/ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.getthemes */
   @:SinceClink("1.7.0")
   @:native("getthemes")
   overload function getThemes(name:String):String;

   /** https://chrisant996.github.io/clink/clink.html#clink.hinter */
   @:SinceClink("1.6.22")
   static function hinter(?priority:Int): /*TODO*/ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.lower
    * ```
    * >>> Clink.lower("Äpfel") == "äpfel"
    * ```
    */
   @:SinceClink("0.4.9")
   @:allow(clink.TestRunner)
   @:allow(clink.util.Strings)
   private static function lower(text:String):String;

   /** https://chrisant996.github.io/clink/clink.html#clink.onaftercommand
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L359 */
   @:SinceClink("1.2.50")
   @:native("onaftercommand")
   static function onAfterCommand(func:() -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onbeginedit
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L146 */
   @:SinceClink("1.1.11")
   @:native("onbeginedit")
   static function onBeginEdit(func:() -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oncommand
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L229 */
   @:SinceClink("1.3.12")
   @:native("oncommand")
   static function onCommand(func:(lineState:LineState, commandInfo:{
      command:String,
      quoted:Bool,
      type:String,
      file:String
   }) -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.ondisplaymatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L250 */
   @:SinceClink("1.1.12")
   @:native("ondisplaymatches")
   static function onDisplayMatches(func:(matches:LuaArray<Match>, popup:Bool) -> LuaArray<Match>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onendedit
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L192 */
   @:SinceClink("1.1.20")
   @:native("onendedit")
   static function onEndEdit(func:(line:String) -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onfilterinput
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L207 */
   @:SinceClink("1.2.16")
   @:native("onfilterinput")
   static function onFilterInput(func:(line:String) -> OnFilterInputResult):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onfiltermatches
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L302 */
   @:SinceClink("1.1.41")
   @:native("onfiltermatches")
   static function onFilterMatches(func:(matches:LuaArray<Match>, completionType:CompletionType,
      filenameCompletionDesired:Bool) -> LuaArray<Match>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onhistory */
   @:SinceClink("1.5.13")
   @:native("onhistory")
   static function onHistory(func:() -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oninject
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L136 */
   @:SinceClink("1.1.21")
   @:native("oninject")
   static function onInject(func:() -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.oninputlinechanged
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L313 */
   @:SinceClink("1.4.18")
   @:native("oninputlinechanged")
   static function onInputLineChanged(func:(line:String) -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.onprovideline
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/events.lua#L313 */
   @:SinceClink("1.3.18")
   @:native("onprovideline")
   static function onProvideLine(func:(line:String) -> Null<String>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.parseline */
   @:SinceClink("1.3.37")
   @:native("parseline")
   static function parseLine(line:String):LuaArray<LineState>;

   /** https://chrisant996.github.io/clink/clink.html#clink.popuplist
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L465 */
   @:SinceClink("1.2.17")
   @:native("popuplist")
   static function popupList(title:String, items:LuaArray<{value:String, ?display:String, ?description:String}>, ?index:Int,
      @:SinceClink("1.3.41")
      ?del_callback:(index:Int) -> Bool):Null<PopupListResult>;

   /** https://chrisant996.github.io/clink/clink.html#clink.print
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L63 */
   @:SinceClink("1.2.11")
   static function print(...values:Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.promptcoroutine */
   @:SinceClink("1.2.10")
   @:native("promptcoroutine")
   static function promptCoroutine<T>(func:() -> T):Null<T>;

   /** https://chrisant996.github.io/clink/clink.html#clink.promptfilter */
   @:SinceClink("1.0.0")
   @:native("promptfilter")
   static function promptFilter(?priority:Int):PromptFilter;

   /** https://chrisant996.github.io/clink/clink.html#clink.readtheme */
   @:SinceClink("1.7.0")
   @:native("readtheme")
   static function readTheme(?priority:Int): /* TODO */ Dynamic;

   /** https://chrisant996.github.io/clink/clink.html#clink.reclassifyline */
   @:SinceClink("1.3.9")
   @:native("reclassifyline")
   static function reclassifyLine():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.recognizecommand */
   @:SinceClink("1.3.38")
   @:native("recognizecommand")
   overload static function recognizeCommand(line:String, word:String, ?quoted:Bool):RecognizeCommandResult;

   /** https://chrisant996.github.io/clink/clink.html#clink.recognizecommand */
   @:SinceClink("1.3.38")
   @:native("recognizecommand")
   overload static function recognizeCommand(word:String, ?quoted:Bool):RecognizeCommandResult;

   /** https://chrisant996.github.io/clink/clink.html#clink.refilterafterterminalresize */
   @:SinceClink("1.4.0")
   @:native("refilterafterterminalresize")
   static function refilterAfterTerminalResize(refilter:Bool):Bool;

   /** https://chrisant996.github.io/clink/clink.html#clink.refilterprompt
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L975 */
   @:SinceClink("1.2.46")
   @:native("refilterPrompt")
   static function refilterprompt():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.reload
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L951 */
   @:SinceClink("1.2.29")
   static function reload():Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.runcoroutineuntilcomplete */
   @:SinceClink("1.3.5")
   @:native("runcoroutineuntilcomplete")
   static function runCoroutineUntilComplete(corountine:Coroutine<Function>):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.runonmain */
   @:SinceClink("1.5.21")
   @:native("runonmain")
   static function runOnMain(func:() -> Any):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.setcoroutineinterval */
   @:SinceClink("1.3.1")
   @:native("setcoroutineinterval")
   static function setCoroutineInterval(corountine:Coroutine<Function>, ?interval:Int):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.setcoroutinename */
   @:SinceClink("1.3.1")
   @:native("setcoroutinename")
   static function setCoroutineName(corountine:Coroutine<Function>, name:String):Void;

   /** https://chrisant996.github.io/clink/clink.html#clink.suggester
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/app/scripts/suggest.lua#L126
    * >>> Clink.suggester("somename") != null
    */
   @:SinceClink("1.2.47")
   static function suggester(name:String):Suggester;

   /** https://chrisant996.github.io/clink/clink.html#clink.translateslashes
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/clink_api.cpp#L858 */
   @:SinceClink("1.2.7")
   @:native("translateslashes")
   static function translateSlashes(?mode:SlashTranslation):Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.upper
    * ```
    * >>> Clink.upper("äpfel") == "ÄPFEL"
    * ```
    */
   @:SinceClink("1.1.5")
   @:allow(clink.TestRunner)
   @:allow(clink.util.Strings)
   private static function upper(text:String):String;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_commit */
   @:SinceClink("1.1.10")
   @:native("version_commit")
   static final versionCommit:String;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_encoded */
   @:SinceClink("1.1.10")
   @:native("version_encoded")
   static final versionEncoded:String;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_major */
   @:SinceClink("1.1.10")
   @:native("version_major")
   static final versionMajor:Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_minor */
   @:SinceClink("1.1.10")
   @:native("version_minor")
   static final versionMinor:Int;

   /** https://chrisant996.github.io/clink/clink.html#clink.version_patch */
   @:SinceClink("1.1.10")
   @:native("version_patch")
   static final versionPatch:Int;
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
