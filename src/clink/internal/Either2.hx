/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

abstract Either2<A, B>(_Either2<A, B>) {

   @:from
   inline static function fromA<A, B>(value:A):Either2<A, B>
      return new Either2(a(value));

   @:from
   inline static function fromB<A, B>(value:B):Either2<A, B>
      return new Either2(b(value));

   inline public function new(value:_Either2<A, B>)
      this = value;

   public var value(get, never):_Either2<A, B>;

   inline function get_value():_Either2<A, B>
      return this;

   @:to
   inline public function toEither3<C>():Either3<A, B, C> {
      return switch (this) {
         case a(v): new Either3(a(v));
         case b(v): new Either3(b(v));
      }
   }
}


@:noDoc @:dox(hide)
private enum _Either2<A, B> {
   a(v:A);
   b(v:B);
}
