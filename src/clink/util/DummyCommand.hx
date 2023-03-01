/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import clink.api.ArgMatcher;
import clink.api.LineState;
import clink.api.MatchBuilder;
import clink.api.MatchBuilder.Match;
import clink.api.Clink;

class DummyCommand {

   public static function registerAs(commandName:String) {
      Clink.argMatcher(commandName) //
         .setDelayedInitializer(registerNow)
         .noFiles();
   }

   static function registerNow(parser:ArgMatcher, commandWord:String) {
      parser //
      // flags
         .addFlag("-a")
         .addFlags(["-b", "-c"])
         .addFlag("-d", ["a", "b", "c"]) // Static choices
         .addFlags(["-e", "--ee"], [Clink.dirMatches]) // ChoicesGenerator1Arg
         .addFlags(["-f", "--ff"], arg_choices_generator) // ChoicesGenerator5Args
         .addFlags(["-h", "--hh"], [Suggest.files]) // ChoicesGenerator1Arg

         .addFlags(["-i", "--ii"], [Suggest.range(10, 20, {step: 2, stringify: idx -> "level" + idx})]) // ChoicesGenerator1Arg
         .addFlags(["-j", "--jj"], [Suggest.filesEndingWith(".png")]) // ChoicesGenerator1Arg
         .addFlags(["-k", "--k"], Clink.argMatcher().addArg(["AAA", "BBB", Suggest.dirs])) // ArgMatcher

         .addFlags(["-q", "--qq"], Suggest.nothing) // ArgMatcher that stops acompletion
            // 1st positional arg:
         .addArg(["AA", "BB"])
            // 2nd positional arg
         .addArg([
            "AAA",
            Suggest.dirs, // ChoicesGenerator1Arg
            // choices with further args (ArgWithChoices)
            {name: "BBB", choices: ["X", "Y"]}, // Static choices
            {name: "CCC", choices: [Clink.dirMatches]}, // ChoicesGenerator1Arg
            {name: "DDD", choices: [arg_choices_generator]}, // ChoicesGenerator5Args
            {name: "EEE", choices: [Suggest.files]}, // ArgMatcher
            {name: "FFF", choices: [Suggest.filesEndingWith(".png")]}, // ArgMatcher
            {name: "GGG", choices: (["X", "Y", Suggest.filesEndingWith(".png"), arg_choices_generator] : Array<Dynamic> /*TODO*/)}, // mixed
            {name: "HHH", choices: Clink.argMatcher().addFlags(["-000", "-111"])}, // Arg with local flags

         ], {noSort: true}) //
            // don't suggest files after last positional arg
         .noFiles();
   }

   static function arg_choices_generator(word:String, wordIndex:Int, lineState:LineState, matchBuilder:MatchBuilder,
         userData:LuaTable<Any>):LuaArray<Match>
      return LuaArray.fromArray([{match: "x" + wordIndex}, {match: "y" + wordIndex}]);

   static function flags_generator1(word:String):LuaArray<String> {
      return LuaArray.from("-AA", "-BBB");
   }

   static function flags_generator2(word:String, wordIndex:Int, lineState:LineState, matchBuilder:MatchBuilder,
         userData:LuaTable<Any>):LuaArray<Match> {
      return LuaArray.from({match: "-AAAA"}, {match: "-BBBB"});
   }
}
