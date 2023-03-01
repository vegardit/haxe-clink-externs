/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

abstract Either3<A, B, C>(_Either3<A, B, C>) {

   @:from
   inline static function fromA<A, B, C>(value:A):Either3<A, B, C>
      return new Either3(a(value));

   @:from
   inline static function fromB<A, B, C>(value:B):Either3<A, B, C>
      return new Either3(b(value));

   @:from
   inline static function fromC<A, B, C>(value:C):Either3<A, B, C>
      return new Either3(c(value));

   inline public function new(value:_Either3<A, B, C>)
      this = value;

   public var value(get, never):_Either3<A, B, C>;

   inline function get_value():_Either3<A, B, C>
      return this;

   @:to
   inline public function toEither4<D>():Either4<A, B, C, D> {
      return switch (this) {
         case a(v): new Either4(a(v));
         case b(v): new Either4(b(v));
         case c(v): new Either4(c(v));
      }
   }
}


@:noDoc @:dox(hide)
private enum _Either3<A, B, C> {
   a(v:A);
   b(v:B);
   c(v:C);
}
