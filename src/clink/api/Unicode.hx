/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.api;

import lua.NativeIterator;

/**
 * https://chrisant996.github.io/clink/clink.html#unicode
 * https://github.com/chrisant996/clink/blob/master/clink/lua/src/unicode_api.cpp
 */
@:ClinkAPI("1.7.7")
@:native("unicode")
extern class Unicode {
   /** https://chrisant996.github.io/clink/clink.html#unicode.fromcodepage */
   @:SinceClink("1.3.27")
   @:native("fromcodepage")
   static function fromCodePage(text:String, ?codepage:Int):Null<String>;

   /** https://chrisant996.github.io/clink/clink.html#unicode.isnormalized */
   @:SinceClink("1.3.26")
   @:native("isnormalized")
   static function isNormalized(form:NormalizationForm, text:String):IsNormalizedResult;

   /** https://chrisant996.github.io/clink/clink.html#unicode.iter */
   @:SinceClink("1.3.26")
   @:native("iter")
   static function iterator(text:String):NativeIterator<String>;

   /** https://chrisant996.github.io/clink/clink.html#unicode.normalize */
   @:SinceClink("1.3.26")
   static function normalize(form:NormalizationForm, text:String):NormalizeResult;

   /** https://chrisant996.github.io/clink/clink.html#unicode.tocodepage */
   @:SinceClink("1.3.27")
   @:native("tocodepage")
   static function toCodePage(text:String, ?codepage:Int):Null<String>;
}

/** https://chrisant996.github.io/clink/clink.html#unicode.isnormalized */
enum abstract NormalizationForm(Int) {
   final CANONICAL_COMPOSITION = 1;
   final CANONICAL_DECOMPOSITION = 2;
   final COMPATIBILITY_COMPOSITION = 3;
   final COMPATIBILITY_DECOMPOSITION = 4;
}

/** https://chrisant996.github.io/clink/clink.html#unicode.isnormalized */
@:multiReturn
extern class IsNormalizedResult {
   final success:Bool;
   final errorCode:Null<Int>;
}

/** https://chrisant996.github.io/clink/clink.html#unicode.isnormalized */
@:multiReturn
extern class NormalizeResult {
   final normalized:String;
   final errorCode:Null<Int>;
}
