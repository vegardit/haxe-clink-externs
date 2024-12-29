/*
 * SPDX-FileCopyrightText: © Vegard IT GmbH (https://vegardit.com) and contributors
 * SPDX-FileContributor: Sebastian Thomschke, Vegard IT GmbH
 * SPDX-License-Identifier: MIT
 * SPDX-ArtifactOfProjectHomePage: https://github.com/vegardit/haxe-clink-externs
 */
package clink;

import clink.api.*;
import clink.util.*;
import hx.doctest.DocTestRunner;

/**
 * The test runner needs to be run with Clink's embedded Lua interpreter using the command "clink lua <path to TestRunner.lua>".
 *
 * The following classes/functiosn are currently not available during testing:
 * - clink.api.Clink (functions derived from arguments.lua, events.lua, generator.lua)
 * - clink.api.RL
 */
@:build(hx.doctest.DocTestGenerator.generateDocTests())
@:keep // prevent DCEing of manually created testXYZ() methods
class TestRunner extends DocTestRunner {

   public static function main() {
      final runner = new TestRunner();
      runner.runAndExit();
   }

   function new() {
      super();
      trace('Testing with:');
      trace('- Clink ${Clink.versionMajor}.${Clink.versionMinor}.${Clink.versionPatch}.${Clink.versionCommit}');
      trace('- ${lua.Lua._VERSION}');
   }

   function testHaxePatches() {
      assertEquals(Sys.command("dir"), 0);
   }

   function testClinkVersion() {
      assertNotNull(Clink.versionCommit);
      assertNotNull(Clink.versionEncoded);
      assertNotNull(Clink.versionMajor);
      assertNotNull(Clink.versionMinor);
      assertNotNull(Clink.versionPatch);
   }

   function testConsole() {
      final colorTable = Console.getColorTable();
      if (Sys.getEnv("CI") == "true" && colorTable == null) {
        return;
      }
      assertNotNull(colorTable.get(1));
      assertNotNull(colorTable.get(colorTable.background));
      assertNotNull(colorTable.get(colorTable.foreground));
   }

   function testOS() {
      final orig = OS.getClipboardText();
      OS.setClipboardText("clink-test");
      assertEquals(OS.getClipboardText(), "clink-test");
      OS.setClipboardText(orig == null ? "" : orig);

      assertEquals(OS.getEnv("FOO"), null);
      OS.setEnv("FOO", "1");
      assertEquals(OS.getEnv("FOO"), "1");
      assertEquals(OS.getEnv("FOO"), Sys.getEnv("FOO"));

      assertNotNull(OS.getCWD());
      assertEquals(OS.getCWD(), Sys.getCwd());
   }

   function testOS_findFiles() {
      final findResult = OS.findFiles("*", 1);
      final files1 = new Map<String, OS.FileInfo>();
      var file:Dynamic;
      while ((file = findResult.next()) != null) {
         final fileInfo:OS.FileInfo = cast file;
         files1.set(fileInfo.name, fileInfo);
      }
      findResult.close();
      assertTrue(files1.exists("README.md"));

      final files2 = new Map<String, OS.FileInfo>();
      final findResult = OS.findFiles("*", 1);
      for (file in findResult.files().toIterator()) {
         final fileInfo:OS.FileInfo = cast file;
         files2.set(fileInfo.name, fileInfo);
      }
      findResult.close();
      assertTrue(files2.exists("README.md"));
      assertEquals(files1, files2);
   }

   function testSettings() {
      assertEquals(Settings.formatcolor("0;1"), "bold");
      assertEquals(Settings.formatcolor("1"), "sgr 1");
      assertEquals(Settings.parsecolor("bold"), "0;1");
      assertEquals(Settings.parsecolor("underline green"), "0;4;32");

      assertNull(Settings.get("enum"));
      assertTrue(Settings.addEnum("enum", ["a", "b"]));
      assertEquals(Settings.get("enum"), "a");
      Settings.set("enum", "b");
      assertEquals(Settings.get("enum"), "b");
      assertFalse(Settings.set("enum", "c"));
      assertEquals(Settings.get("enum"), "b");

      assertNull(Settings.get("bool"));
      assertTrue(Settings.add("bool", true));
      assertEquals(Settings.get("bool"), true);
      Settings.set("bool", false);
      assertEquals(Settings.get("bool"), false);
      assertFalse(Settings.set("bool", "foo"));
      assertEquals(Settings.get("bool"), false);
      Settings.clear("bool");
      assertEquals(Settings.get("bool"), true);

      assertNull(Settings.get("int"));
      assertTrue(Settings.add("int", 1));
      assertEquals(Settings.get("int"), 1);
      Settings.set("int", 2);
      assertEquals(Settings.get("int"), 2);
      assertFalse(Settings.set("int", "foo"));
      assertEquals(Settings.get("int"), 2);
      Settings.clear("int");
      assertEquals(Settings.get("int"), 1);
   }

   function testLuaArray() {
      final a = LuaArray.fromArray(["a"]);
      assertFalse(a.isEmpty());
      a.add("b");
      assertEquals(a.length(), 2);
      assertEquals('$a', "{ 1 : a, 2 : b }");
      assertTrue(a.contains("a"));
      assertTrue(a.contains("b"));
      assertFalse(a.contains("c"));
      assertEquals('${[for (k => v in a) '$k=>$v']}', "[1=>a,2=>b]");
      assertEquals(a.toArray(), ["a", "b"]);
      assertEquals('${[for (k => v in a.keyValueIterator()) '$k=>$v']}', "[1=>a,2=>b]");
   }

   function testLuaMap() {
      final m = LuaMap.fromMap(["a" => 1]);
      assertFalse(m.isEmpty());
      m["b"] = 2;
      assertEquals(m.size(), 2);
      assertTrue(m.containsKey("a"));
      assertTrue(m.containsValue(1));
      assertTrue(m.containsKey("b"));
      assertTrue(m.containsValue(2));
      final keys = [for (k in m.keys()) k];
      keys.sort(Reflect.compare);
      assertEquals(keys, ["a", "b"]);
      final values = [for (v in m.values()) v];
      values.sort(Reflect.compare);
      assertEquals(values, [1, 2]);
   }

   function testLuaTable() {
      final t = LuaTable.fromArray(["a"]);
      assertFalse(t.isEmpty());
      t.add("b");
      assertEquals(t.size(), 2);
      assertEquals('$t', "{ 1 : a, 2 : b }");
      assertTrue(t.containsKey(1));
      assertTrue(t.containsKey(2));
      assertTrue(t.containsValue("a"));
      assertTrue(t.containsValue("b"));

      t["x"] = "c";
      t.y = "d";
      assertEquals(t.size(), 4);
      assertTrue(t.containsKey("x"));
      assertTrue(t.containsValue("c"));

      for (p in t.keyValueIterator()) {
         assertNotNull(p.key);
         assertNotNull(p.value);
      }
      final keys = [for (e in t.keys()) e];
      keys.sort((a, b) -> Reflect.compare(Std.string(a), Std.string(b)));
      assertEquals(keys, [1, 2, "x", "y"]);

      final values = [for (e in t.values()) e];
      values.sort(Reflect.compare);
      assertEquals(values, ["a", "b", "c", "d"]);

      // test array view
      final a = t.asLuaArray();
      assertFalse(a.isEmpty());
      assertEquals(a.length(), 2);
      assertTrue(a.contains("a"));
      assertTrue(a.contains("b"));
      assertFalse(a.contains("c"));
      assertEquals('${[for (k => v in a) '$k=>$v']}', "[1=>a,2=>b]");
      assertEquals(a.toArray(), ["a", "b"]);
      assertEquals('${[for (k => v in a.keyValueIterator()) '$k=>$v']}', "[1=>a,2=>b]");

      // test map view
      final m = t.asLuaMap();
      assertFalse(m.isEmpty());
      assertEquals(m.size(), 2);
      assertFalse(a.contains("x"));
      assertFalse(a.contains("y"));
      assertFalse(m.containsValue("a"));
      assertFalse(m.containsValue("b"));
      assertTrue(m.containsValue("c"));
      assertTrue(m.containsValue("d"));
   }
}
