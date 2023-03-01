/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

abstract Either4<A, B, C, D>(_Either4<A, B, C, D>) {

   @:from
   inline static function fromA<A, B, C, D>(value:A):Either4<A, B, C, D>
      return new Either4(a(value));

   @:from
   inline static function fromB<A, B, C, D>(value:B):Either4<A, B, C, D>
      return new Either4(b(value));

   @:from
   inline static function fromC<A, B, C, D>(value:C):Either4<A, B, C, D>
      return new Either4(c(value));

   @:from
   inline static function fromD<A, B, C, D>(value:D):Either4<A, B, C, D>
      return new Either4(d(value));

   inline public function new(value:_Either4<A, B, C, D>)
      this = value;

   public var value(get, never):_Either4<A, B, C, D>;

   inline function get_value():_Either4<A, B, C, D>
      return this;

   @:to
   inline public function toEither5<E>():Either5<A, B, C, D, E> {
      return switch (this) {
         case a(v): new Either5(a(v));
         case b(v): new Either5(b(v));
         case c(v): new Either5(c(v));
         case d(v): new Either5(d(v));
      }
   }
}


@:noDoc @:dox(hide)
private enum _Either4<A, B, C, D> {
   a(v:A);
   b(v:B);
   c(v:C);
   d(v:D);
}
