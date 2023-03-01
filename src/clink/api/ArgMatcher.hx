/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import clink.internal.EitherType4;
import haxe.extern.EitherType;
import clink.api.MatchBuilder.Match;
import clink.internal.EitherType3;
import clink.util.LuaArray;
import clink.util.LuaTable;

/**
 * https://chrisant996.github.io/clink/clink.html#_argmatcher
 * https://github.com/chrisant996/clink/blob/master/clink/lua/scripts/arguments.lua
 */
@:forward
abstract ArgMatcher(ArgMatcherExtern) from ArgMatcherExtern to ArgMatcherExtern {

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg
    *
    * Examples:
    * - argMatcher.addArg(["red", "green", "blue"]); // static choices
    * - argMatcher.addArg(["red", "green", "blue"], { noSort: true });
    * - argMatcher.addArg([Clink.dirMatches]); // dynamic choices
    * - argMatcher.addArg(["build.xml", Clink.dirMatches]); // static plus dynamic choices 
    * - argMatcher.addArg([{name:"list", ["images", "templates"]}); // arg with sub-arg
    */
   public function addArg(choices:EitherType<Array<EitherType<ChoiceOrGenerator, ArgWithChoices>>, ChoicesGenerator>,
         ?opts:AddArgOptions):ArgMatcher {
      final cfg = new LuaTable<Any>();
      if (choices is Array) {
         for (choice in cast(choices, Array<Dynamic>)) {
            if (!Reflect.isFunction(choice) && Reflect.hasField(choice, "name") && Reflect.hasField(choice, "choices")) {
               final argWithChoices:ArgWithChoices = choice;
               cfg.add(untyped __lua__("{0}..{1}", argWithChoices.name, subArgChoicesToArgMatcher(argWithChoices.choices)));
            } else {
               cfg.add(choice);
            }
         }
      } else { // ChoicesGenerator
         cfg.add(choices);
      }
      @:nullSafety(Off)
      if (opts != null) {
         cfg.delayinit = opts.delayedInitializer;
         cfg.fromhistory = opts.fromHistory;
         cfg.loopchars = opts.loopChars;
         cfg.nosort = opts.noSort;
         cfg.onarg = opts.onArg;
      }
      this._addarg(cfg);

      return this;
   }

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions */
   inline public function addDescription(descr:EitherType<ArgsDescription, FlagsDescription>):ArgMatcher
      return addDescriptions(descr);

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions */
   public function addDescriptions(...descr:EitherType<ArgsDescription, FlagsDescription>):ArgMatcher {
      for (d in descr) {
         if (d is ArgsDescription) {
            final arg:ArgsDescription = d;
            final cfg = LuaTable.fromArray(arg.args);
            cfg.description = arg.descr;
            this._adddescriptions(cfg);
         } else {
            final flag:FlagsDescription = d;
            final cfg = LuaTable.fromArray(flag.flags);
            cfg.description = flag.descr;
            this._adddescriptions(cfg);
         }
      }

      return this;
   }

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:addflags */
   public function addFlag(flag:String, ?choices:SubArgChoices, ?opts:AddFlagOptions):ArgMatcher {
      if (choices == null)
         return this._addflags([flag]);
      final cfg = new LuaTable<Any>();
      cfg.add(untyped __lua__("{0}..{1}", flag, subArgChoicesToArgMatcher(choices)));
      @:nullSafety(Off)
      if (opts != null) {
         cfg.delayinit = opts.delayedInitializer;
         cfg.fromhistory = opts.fromHistory;
         cfg.onarg = opts.onArg;
      }
      cfg.nosort = true;
      this._addflags(cfg);

      return this;
   }

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:addflags */
   public function addFlags(flags:Array<String>, ?choices:SubArgChoices, ?opts:AddFlagOptions):ArgMatcher {
      for (f in flags)
         addFlag(f, choices, opts);
      return this;
   }

   private function subArgChoicesToArgMatcher(choices:SubArgChoices):ArgMatcher {
      if (choices is Array) // Array<ChoiceOrGenerator>
         return Clink.argMatcher().addArg(choices);
      if (!Reflect.isFunction(choices) && Reflect.hasField(choices, "_args") && Reflect.hasField(choices, "_priority")) // ArgMatcher
         return choices;
      return Clink.argMatcher().addArg([choices]); // ChoiceOrGenerator
   }
}

@:allow(clink.api.ArgMatcher)
@:allow(clink.api.ArgBuilder)
private extern class ArgMatcherExtern {
   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L750 */
   @:native("addarg")
   private overload function _addarg(choices:LuaTable<Any>):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L986 */
   @:native("adddescriptions")
   private function _adddescriptions(...descr:LuaTable<Any>):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:addflags
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L803 */
   @:native("addflags")
   private function _addflags(choices:LuaTable<Any>):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:chaincommand
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1090 */
   @:native("chaincommand")
   function chainCommand():ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:hideflags
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L860 */
   @:native("hideflags")
   function hideFlags(...flags:String):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:loop
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L888 */
   function loop(index:Int):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:nofiles
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1084 */
   @:native("nofiles")
   function noFiles():ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:reset
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L722 */
   function reset():ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:setclassifier
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1138 */
   @:native("setclassifier")
   function setClassifier(handler:Classifier):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:setdelayinit
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L1151 */
   @:native("setdelayinit")
   function setDelayedInitializer(handler:(argMatcher:ArgMatcher, commandWord:String) -> Void):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:setendofflags
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L964 */
   @:native("setendofflags")
   public extern overload function setEndOfFlags(enabled:Bool):ArgMatcher;

   @:native("setendofflags")
   public extern overload function setEndOfFlags(endofflags:String = "--"):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:setflagprefix
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L907 */
   @:native("setflagprefix")
   function setFlagPrefix(...prefixes:String):ArgMatcher;

   /** https://chrisant996.github.io/clink/clink.html#_argmatcher:setflagsanywhere
    * https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/scripts/arguments.lua#L947 */
   @:native("setflagsanywhere")
   function setFlagsAnywhere(enabled:Bool):ArgMatcher;
}

// ============================================================================
// ArgMatcher.addArg/addFlag input types
// https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg
// https://chrisant996.github.io/clink/clink.html#_argmatcher:addflags
// ============================================================================

/** */
typedef Choice = EitherType<Match, String>;

/** https://chrisant996.github.io/clink/clink.html#argmatcher_functions */
typedef ChoicesGenerator0Args = () -> LuaArray<Choice>;

/** https://chrisant996.github.io/clink/clink.html#argmatcher_functions */
typedef ChoicesGenerator1Arg = (word:String) -> LuaArray<Choice>;

/** https://chrisant996.github.io/clink/clink.html#argmatcher_functions */
typedef ChoicesGenerator3Args = (word:String, wordIndex:Int, lineState:LineState) -> LuaArray<Choice>;

/** https://chrisant996.github.io/clink/clink.html#argmatcher_functions */
typedef ChoicesGenerator5Args = (word:String, wordIndex:Int, lineState:LineState, matchBuilder:MatchBuilder,
   userData:LuaTable<Any>) -> LuaArray<Choice>;

typedef ChoicesGenerator = EitherType4<ChoicesGenerator0Args, ChoicesGenerator1Arg, ChoicesGenerator3Args, ChoicesGenerator5Args>;
/** https://chrisant996.github.io/clink/clink.html#argmatcher_functions */
typedef ChoiceOrGenerator = EitherType<Choice, ChoicesGenerator>;

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg */
typedef SubArgChoices = EitherType3<ChoiceOrGenerator, Array<ChoiceOrGenerator>, ArgMatcher>;

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg */
typedef ArgWithChoices = {
   name:String,
   choices:SubArgChoices
}

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:addflags */
typedef AddFlagOptions = {
   /** https://chrisant996.github.io/clink/clink.html#addarg_delayinit */
   ?delayedInitializer:(argMatcher:ArgMatcher, argIndex:Int) -> Void,
   ?fromHistory:Bool,
   ?noSort:Bool,
   ?onArg:(argIndex:Int, word:String, wordIndex:Int, lineState:LineState, userData:LuaTable<Any>) -> Void
}

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:addarg */
typedef AddArgOptions = AddFlagOptions & {
   ?loopChars:String
}

// ============================================================================
// ArgMatcher.addDescription input types
// https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions
// ============================================================================

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions */
@:structInit
final class ArgsDescription {

   public var args:Array<String>;
   public var descr:String;

   function new(args:Array<String>, descr:String) {
      this.args = args;
      this.descr = descr;
   }
}

/** https://chrisant996.github.io/clink/clink.html#_argmatcher:adddescriptions */
@:structInit
final class FlagsDescription {

   public var flags:Array<String>;
   public var valueName:Null<String>;
   public var descr:String;

   function new(flags:Array<String>, descr:String, ?valueName:String) {
      this.flags = flags;
      this.descr = descr;
      this.valueName = valueName;
   }
}

// ============================================================================
// ArgMatcher.setClassifier input types
// https://chrisant996.github.io/clink/clink.html#_argmatcher:setclassifier
// ============================================================================

/** https://chrisant996.github.io/clink/clink.html#classifier_override_arguments */
typedef Classifier = (argIndex:Int, word:String, wordIndex:Int, lineState:LineState, classifications:WordClassifications) -> Void;

/**
 * https://chrisant996.github.io/clink/clink.html#word_classifications
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/lua_word_classifications.cpp
 */
abstract WordClassifications(WordClassificationsExtern) {

   inline public function classifyWord(wordIndex:Int, wordClass:WordClass, ?overwrite:Bool):Void {
      this.classifyword(wordIndex, getWordClassCode(wordClass), overwrite);
   }

   inline public function applyColor(start:Int, length:Int, color:String, ?overwrite:Bool):Void
      this.applycolor(start, length, color, overwrite);
}

private extern class WordClassificationsExtern {
   /** https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/lua_word_classifications.cpp#L44 */
   function classifyword(wordIndex:Int, wordClass:String, ?overwrite:Bool):Void;

   /** https://github.com/chrisant996/clink/blob/236abadf5f9569bc93c8b92f0912709154a527aa/clink/lua/src/lua_word_classifications.cpp#L110 */
   function applycolor(start:Int, length:Int, color:String, ?overwrite:Bool):Void;
}


/** https://chrisant996.github.io/clink/clink.html#word_classifications:classifyword */ @:keep
enum WordClass {
   ARGUMENT;
   COMMAND;
   DOSKEY_ALIAS;
   FLAG;
   EXECUTABLE;
   UNRECOGNIZED;
   OTHER;
   UNEXPECTED;
   ARGMATCHER(wordClass:WordClass);
}

private function getWordClassCode(wordClass:WordClass) {
   return switch (wordClass) {
      case ARGUMENT: "a";
      case COMMAND: "c";
      case DOSKEY_ALIAS: "d";
      case FLAG: "f";
      case EXECUTABLE: "x";
      case UNRECOGNIZED: "u";
      case OTHER: "o";
      case UNEXPECTED: "n";
      case ARGMATCHER(wc): "a" + getWordClassCode(wc);
   };
}
