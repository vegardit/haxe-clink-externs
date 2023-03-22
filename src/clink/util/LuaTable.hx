/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.util;

import lua.PairTools;
import lua.Table;

import clink.internal.Either2;
import clink.internal.Either3;

/** Lua table keys can be either Int or String */
typedef IntOrString = haxe.extern.EitherType<Int, String>;

/**
 * A Lua table is an odd creature as it combines numeric-index based access (array/list behaviour) with string-key/value based access (map/dictionary behaviour).
 */
@:forward // to implement Dynamic https://community.openfl.org/t/solved-haxe-abstract-class-with-implements-dynamic-dynamic-possible/6689/3
abstract LuaTable<V>(Table<IntOrString, V>) from Table<IntOrString, V> to Table<IntOrString, V> {

   @:from
   inline public static function fromArray<V>(arr:Array<V>):LuaTable<V>
      return Table.fromArray(arr);

   @:from
   inline public static function fromDynamic<V>(dyn:Dynamic):LuaTable<V>
      return Table.fromDynamic(dyn);

   @:from
   inline public static function fromMap<IntOrString, V>(map:Map<IntOrString, V>):LuaTable<V>
      return Table.fromMap(map);

   public function new(?arr:Array<V>, ?map:Map<IntOrString, V>) {
      if (arr == null) {
         if (map == null)
            this = Table.create();
         else
            this = fromMap(map);
      } else {
         this = fromArray(arr);
         if (map != null)
            setAll(map);
      }
   }

   inline public function isEmpty():Bool
      return !keys().hasNext();

   public function size():Int {
      var size = 0;
      forEach((k, v) -> size++);
      return size;
   }

   @:arrayAccess
   public inline function get(key:Dynamic)
      return this[key];

   @:arrayAccess
   public inline function set(key:IntOrString, v:V):V {
      this[key] = v;
      return v;
   }

   inline public function setAll(items:Either2<Map<IntOrString, V>, Dynamic>):Void
      asLuaMap().setAll(items);

   inline public function add(v:V):Void
      asLuaArray().add(v);

   inline public function addAll(items:Either3<Iterator<V>, Iterable<V>, Array<V>>):Void
      asLuaArray().addAll(items);

   inline public function containsKey(k:IntOrString):Bool
      return this[k] != null;

   public function containsValue(v:V):Bool {
      final it = PairTools.pairsIterator(this);
      while (it.hasNext())
         if (it.next().value == v) return true;
      return false;
   }

   inline public function forEach(func:(index:IntOrString, value:V) -> Void):Void
      PairTools.pairsEach(this, func);

   inline public function keyValueIterator():Iterator<Pair<IntOrString, V>>
      return PairTools.pairsIterator(this);

   inline public function keys():PairKeyIterator<IntOrString>
      return keyValueIterator();

   inline public function values():PairValueIterator<V>
      return keyValueIterator();

   @:to
   inline public function asLuaArray():LuaArray<V>
      return this;

   @:to
   inline public function asLuaMap():LuaMap<V>
      return this;

   /** Creates a new Haxe Map instance containing all mappings (i.e. string- and int-keyed entries)*/
   @:to
   inline public function toMap():Map<String, V>
      return Table.toMap(this);

   /** Creates a new dynamic object where all string-mapped values are set as fields */
   inline public function toObject<T>():Dynamic<T>
      return Table.toObject(cast this);
}

private typedef NativePair<A, B> = {index:A, value:B}


@:forward(value)
abstract Pair<A, B>(NativePair<A, B>) from NativePair<A, B> to NativePair<A, B> {

   public var key(get, set):A;

   inline function get_key():A
      return this.index;

   inline function set_key(val:A):A {
      this.index = val;
      return val;
   }
}


abstract PairKeyIterator<K>(Iterator<Pair<K, Dynamic>>) from Iterator<Pair<K, Dynamic>> {

   inline public function hasNext():Bool
      return this.hasNext();

   inline public function next():K
      return this.next().key;
}


abstract PairValueIterator<V>(Iterator<Pair<Dynamic, V>>) from Iterator<Pair<Dynamic, V>> {

   inline public function hasNext():Bool
      return this.hasNext();

   inline public function next():V
      return this.next().value;
}
