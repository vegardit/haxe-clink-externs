/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import lua.PairTools;
import lua.Table;

/**
 * Provides a numeric-indexed array view over a Lua table, i.e. only accessing entries with numeric index
 */
abstract LuaArray<V>(Table<Int, V>) from Table<Int, V> to Table<Int, V> {

   @:from
   inline public static function from<V>(...value:V):LuaArray<V> {
      return Table.fromArray(value);
   }

   @:from
   inline public static function fromArray<V>(arr:Array<V>):LuaArray<V> {
      return Table.fromArray(arr);
   }

   @:from
   inline private static function fromLuaTable<V>(t:LuaTable<V>):LuaArray<V> {
      return cast t;
   }

   public function new() {
      this = Table.create();
   }

   public function isEmpty():Bool {
      return !iterator().hasNext();
   }

   public function length():Int {
      var len = 0;
      forEach((k, v) -> len++);
      return len;
   }

   @:arrayAccess
   inline public function get(pos:Int) {
      return this[pos];
   }

   @:arrayAccess
   inline public function set(pos:Int, v:V):V {
      this[pos] = v;
      return v;
   }

   inline public function add(v:V):Void {
      Table.insert(this, v);
   }

   public function contains(v:V):Bool {
      var it = PairTools.ipairsIterator(this);
      while (it.hasNext())
         if (it.next().value == v) return true;
      return false;
   }

   inline public function forEach(func:(index:Int, value:V) -> Void):Void {
      PairTools.ipairsEach(this, func);
   }

   public function iterator():Iterator<V> {
      final it = PairTools.ipairsIterator(this);
      return {
         next: () -> it.next().value,
         hasNext: () -> return it.hasNext()
      }
   }

   public function keyValueIterator():KeyValueIterator<Int, V> {
      final it = PairTools.ipairsIterator(this);
      return {
         next: () -> {
            var res = it.next();
            return {key: res.index, value: res.value};
         },
         hasNext: () -> return it.hasNext()
      }
   }

   /** Creates a new Haxe Array instance containing all indexed values */
   @:to
   inline public function toArray():Array<V> {
      return Table.toArray(this);
   }
}
