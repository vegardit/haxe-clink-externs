/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import lua.PairTools;
import lua.Table;

/** Lua table keys can be either Int or String */
typedef IntOrString = haxe.extern.EitherType<Int, String>;

/**
 * A Lua table is an odd creature as it combines numeric-index based access (array/list behaviour) with string-key/value based access (map/dictionary behaviour).
 */
@:forward // to implement Dynamic https://community.openfl.org/t/solved-haxe-abstract-class-with-implements-dynamic-dynamic-possible/6689/3
abstract LuaTable<V>(Table<IntOrString, V>) from Table<IntOrString, V> to Table<IntOrString, V> {

   @:from
   inline public static function fromArray<V>(arr:Array<V>):LuaTable<V> {
      return Table.fromArray(arr);
   }

   @:from
   inline public static function fromDynamic<V>(dyn:Dynamic):LuaTable<V> {
      return Table.fromDynamic(dyn);
   }

   @:from
   inline public static function fromMap<IntOrString, V>(map:Map<IntOrString, V>):LuaTable<V> {
      return Table.fromMap(map);
   }

   inline public function new() {
      this = Table.create();
   }

   public function isEmpty():Bool {
      return !keys().hasNext();
   }

   public function length():Int {
      var len = 0;
      forEach((k, v) -> len++);
      return len;
   }

   @:arrayAccess
   public inline function get(key:Dynamic) {
      return this[key];
   }

   @:arrayAccess
   public inline function set(key:IntOrString, v:V):V {
      this[key] = v;
      return v;
   }

   inline public function add(v:V):Void {
      Table.insert(this, v);
   }

   inline public function containsKey(k:Dynamic):Bool {
      return this[k] != null;
   }

   public function containsValue(v:V):Bool {
      var it = PairTools.pairsIterator(this);
      while (it.hasNext())
         if (it.next().value == v) return true;
      return false;
   }

   inline public function forEach(func:(index:IntOrString, value:V) -> Void):Void {
      PairTools.pairsEach(this, func);
   }

   public function keyValueIterator():KeyValueIterator<IntOrString, V> {
      final it = PairTools.pairsIterator(this);
      return {
         next: () -> {
            var res = it.next();
            return {key: res.index, value: res.value};
         },
         hasNext: () -> return it.hasNext()
      }
   }

   public function keys():Iterator<IntOrString> {
      final it = PairTools.pairsIterator(this);
      return {
         next: () -> it.next().index,
         hasNext: () -> return it.hasNext()
      }
   }

   public function values():Iterator<V> {
      final it = PairTools.pairsIterator(this);
      return {
         next: () -> it.next().value,
         hasNext: () -> return it.hasNext()
      }
   }

   @:to
   inline public function asLuaArray():LuaArray<V> {
      return this;
   }

   @:to
   inline public function asLuaMap():LuaMap<V> {
      return this;
   }

   /** Creates a new Haxe Map instance containing all mappings */
   @:to
   inline public function toMap():Map<String, V> {
      return Table.toMap(this);
   }

   /** Creates a new dynamic object where all string-mapped values are set as fields */
   inline public function toObject<T>():Dynamic<T> {
      return Table.toObject(cast this);
   }
}
