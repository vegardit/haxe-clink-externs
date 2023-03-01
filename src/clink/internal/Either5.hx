/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

abstract Either5<A, B, C, D, E>(_Either5<A, B, C, D, E>) {

   inline public function new(value:_Either5<A, B, C, D, E>)
      this = value;

   public var value(get, never):_Either5<A, B, C, D, E>;

   inline function get_value():_Either5<A, B, C, D, E>
      return this;

   @:from
   inline static function fromA<A, B, C, D, E>(value:A):Either5<A, B, C, D, E>
      return new Either5(a(value));

   @:from
   inline static function fromB<A, B, C, D, E>(value:B):Either5<A, B, C, D, E>
      return new Either5(b(value));

   @:from
   inline static function fromC<A, B, C, D, E>(value:C):Either5<A, B, C, D, E>
      return new Either5(c(value));

   @:from
   inline static function fromD<A, B, C, D, E>(value:D):Either5<A, B, C, D, E>
      return new Either5(d(value));

   @:from
   inline static function fromE<A, B, C, D, E>(value:E):Either5<A, B, C, D, E>
      return new Either5(e(value));
}


@:noDoc @:dox(hide)
private enum _Either5<A, B, C, D, E> {
   a(v:A);
   b(v:B);
   c(v:C);
   d(v:D);
   e(v:E);
}
