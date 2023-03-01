/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink.internal;

/**
 * <b>IMPORTANT:</b> This class it not part of the API. Direct usage is discouraged.
 */
@:noDoc @:dox(hide)
@:noCompletion
class Macros {

   macro //
   public static function ensureMinimumHaxeVersion() {
      #if (haxe_ver < 4.2)
         throw 'ERROR: Haxe 4.2 or higher is required!';
      #end
      return macro {}
   }

   macro //
   public static function patchHaxeForClinkLua() {

      // remove all references to rex_pcre from Ereg class to prevent
      // module 'rex_pcre' not found: no field package.preload['rex_pcre']
      no.Spoon.bend('EReg', macro class {
         static function __init__():Void {
         }

         public function new(r:String, opt:String):Void
            throw "Unsupported Operation";
      });

      // replace lubliv methods with equivalents from Clink's API
      no.Spoon.bend('Sys', macro class {
         public static function command(cmd:String, ?args:Array<String>):Int {
            #if (lua_ver < 5.2)
               if (args != null && args.length > 0)
                  return lua.Os.execute('"$cmd" "${args.join('" "')}"');
               return lua.Os.execute('"$cmd"');
            #else
               if (args != null && args.length > 0)
                  return lua.Os.execute('"$cmd" "${args.join('" "')}"').status;
               return lua.Os.execute('"$cmd"').status;
            #end
         }

         inline public static function getCwd():String
            return clink.api.OS.getCWD();

         inline public static function getEnv(s:String):String
            return clink.api.OS.getEnv(s);

         inline public static function putEnv(s:String, v:String):Void
            clink.api.OS.setEnv(s, v);

         inline public static function sleep(seconds:Float):Void
            clink.api.OS.sleep(Math.ceil(seconds));

         inline public static function systemName():String
            return "Windows";

         inline public static function time():Float
            return untyped __lua__('os.time(os.date("!*t"))') / 1000;
      });

      no.Spoon.bend('sys.FileSystem', macro class {
         public static function absolutePath(relPath:String):String
            return haxe.io.Path.isAbsolute(relPath) ? relPath : Path.join([clink.api.OS.getCWD(), relPath]);

         public static function exists(path:Null<String>):Bool
            return path == null ? false : clink.api.OS.isDir(path) || clink.api.OS.isFile(path);

         public static function fullPath(relPath:String):String {
            final r = clink.api.OS.getFullPath(relPath);
            if (r.errorNumber == null)
               return r.result;
            throw r;
         }

         inline public static function isDirectory(path:String):Bool
            return clink.api.OS.isDir(path);

         inline public static function createDirectory(path:String):Void
            clink.api.OS.mkDir(path);

         inline public static function deleteDirectory(path:String):Void
            clink.api.OS.rmDir(path);

         public static function readDirectory(path:String):Array<String> {
            final res = new Array<String>();
            for (file in clink.api.OS.globFiles(path + "\\*")) {
               if (StringTools.endsWith(file, "\\"))
                  file = file.substring(0, file.length - 1);
               res.push(file);
            }
            return res;
         }
      });

      return macro {}
   }
}
