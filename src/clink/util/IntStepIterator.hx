/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

class IntStepIterator /*extends IntIterator*/ {

   final stopExclusive:Int;
   final step:Int;
   var i:Int;

   public function new(start:Int, stopExclusive:Int, step:Int = 1) {
      this.i = start;
      this.stopExclusive = stopExclusive;
      this.step = step;
   }

   public inline function hasNext()
      return i < stopExclusive;

   public inline function next()
      return (i += step) - step;
}
