/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

abstract KeyIterator<K>(KeyValueIterator<K, Any>) from KeyValueIterator<K, Any> {

   inline public function hasNext():Bool
      return this.hasNext();

   inline public function next():K
      return this.next().key;
}


abstract ValueIterator<V>(KeyValueIterator<Any, V>) from KeyValueIterator<Any, V> {

   inline public function hasNext():Bool
      return this.hasNext();

   inline public function next():V
      return this.next().value;
}
