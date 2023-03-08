/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import lua.Lua;
import lua.PairTools;
import lua.Table;

/**
 * Provides access to all String-keyed entries of a Lua table
 */
@:forward // to implement Dynamic https://community.openfl.org/t/solved-haxe-abstract-class-with-implements-dynamic-dynamic-possible/6689/3
abstract LuaMap<V>(Table<String, V>) from Table<String, V> to Table<String, V> {

   @:from
   inline public static function fromDynamic<V>(dyn:Dynamic):LuaMap<V>
      return Table.fromDynamic(dyn);

   @:from
   inline public static function fromMap<String, V>(map:Map<String, V>):LuaMap<V>
      return Table.fromMap(map);

   inline public function new()
      this = Table.create();

   public function isEmpty():Bool
      return !keys().hasNext();

   public function size():Int {
      var size = 0;
      forEach((k, v) -> size++);
      return size;
   }

   @:arrayAccess
   inline public function get(key:String)
      return this[untyped key];

   @:arrayAccess
   inline public function set(key:String, v:V):V {
      this[untyped key] = v;
      return v;
   }

   inline public function containsKey(k:String):Bool
      return this[untyped k] != null;

   public function containsValue(v:V):Bool {
      var it = PairTools.pairsIterator(this);
      while (it.hasNext()) {
         final n = it.next();
         if (n.value == v && Std.isOfType(n.index, String)) return true;
      }
      return false;
   }

   inline public function forEach(func:(index:String, value:V) -> Void):Void {
      PairTools.pairsEach(this, (k, v) -> {
         if (Std.isOfType(k, String)) func(k, v);
      });
   }

   @:nullSafety(Off)
   public function keyValueIterator():KeyValueIterator<String, V> {
      var nextKey:Dynamic = null;
      var nextValue:V = null;

      final hasNext = () -> {
         if (nextValue == null) {
            while (true) {
               final next = Lua.next(this, nextKey);
               if (next == null || next.index == null) break;
               nextKey = next.index;
               if (Std.isOfType(next.index, String)) {
                  nextValue = next.value;
                  return break;
               }
            }
         }
         return nextValue != null;
      }
      return {
         next: () -> {
            Lua.assert(hasNext(), "No more values!");
            final v = nextValue;
            nextValue = null;
            return {key: nextKey, value: v}
         },
         hasNext: hasNext
      }
   }

   public function keys():Iterator<String> {
      final it = keyValueIterator();
      return {
         next: () -> it.next().key,
         hasNext: () -> it.hasNext()
      }
   }

   public function values():Iterator<V> {
      final it = keyValueIterator();
      return {
         next: () -> it.next().value,
         hasNext: () -> it.hasNext()
      }
   }

   /** Creates a new dynamic object where all string-mapped values are set as fields */
   inline public function toObject<T>():Dynamic<T>
      return Table.toObject(cast this);

   /** Creates a new Haxe Map instance containing all mappings */
   @:to
   inline public function toMap():Map<String, V> {
      var m = new Map<String, V>();
      for (k => v in keyValueIterator()) {
         m[k] = v;
      }
      return m;
   }
}
