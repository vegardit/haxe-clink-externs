/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import clink.util.LuaArray;
import clink.api.ArgMatcher;
import clink.api.Clink;
import clink.api.MatchBuilder.Match;

using StringTools;

class Suggest {

   public static final nothing = Clink.argMatcher().noFiles();
   public static final dirs = Clink.dirMatches;
   public static final files = Clink.fileMatches;

   public static function filesEndingWith(...suffixes:String):ChoicesGenerator1Arg {
      function get_matches(word:String):LuaArray<Match> {
         final matches = new LuaArray<Match>();
         for (m in Clink.fileMatches(word)) {
            if (m.isDir) {
               matches.add(m);
            } else {
               for (suffix in suffixes) {
                  if (m.path.endsWith(suffix)) {
                     matches.add(m);
                     break;
                  }
               }
            }
         }
         return matches;
      }
      return get_matches;
   }

   /**
    * @param from: lower boundary (inclusive)
    * @param to: upper boundary (inclusive)
    */
   public static function range(from:Int, to:Int, ?opts:RangeOpts):ChoicesGenerator0Args {
      if (opts == null)
         opts = RangeOpts.DEFAULT;
      function get_matches():LuaArray<String> {
         final matches = new LuaArray<String>();
         @:nullSafety(Off)
         for (i in new IntStepIterator(from, to + 1, opts.step)) {
            matches.add(opts.stringify(i));
         }
         return matches;
      }
      return get_matches;
   }
}


@:allow(clink.util.Suggest)
@:structInit
class RangeOpts {

   static final DEFAULT:RangeOpts = new RangeOpts();

   public final step:Int;
   public final stringify:(index:Int) -> String;

   public function new(step:Int = 1, ?stringify:(index:Int) -> String) {
      this.step = step;
      if (stringify == null) // cannot use tenary operator here for some reason on Lua, results in strange output
         this.stringify = Std.string;
      else
         this.stringify = stringify;
   }
}
