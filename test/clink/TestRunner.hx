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

   function testSettings() {
      assertNull(Settings.get("enum"));
      assertTrue(Settings.addEnum("enum", ["a", "b"]));
      assertEquals(Settings.get("enum"), "a");
      assertTrue(Settings.set("enum", "b"));
      assertEquals(Settings.get("enum"), "b");
      assertFalse(Settings.set("enum", "c"));
      assertEquals(Settings.get("enum"), "b");

      assertNull(Settings.get("bool"));
      assertTrue(Settings.add("bool", true));
      assertEquals(Settings.get("bool"), true);
      assertTrue(Settings.set("bool", false));
      assertEquals(Settings.get("bool"), false);
      assertFalse(Settings.set("bool", "foo"));
      assertEquals(Settings.get("bool"), false);

      assertNull(Settings.get("int"));
      assertTrue(Settings.add("int", 1));
      assertEquals(Settings.get("int"), 1);
      assertTrue(Settings.set("int", 2));
      assertEquals(Settings.get("int"), 2);
      assertFalse(Settings.set("int", "foo"));
      assertEquals(Settings.get("int"), 2);
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

   function testLuaTable() {
      final t = LuaTable.fromArray(["a"]);
      assertFalse(t.isEmpty());
      t.add("b");
      assertEquals(t.length(), 2);
      assertEquals('$t', "{ 1 : a, 2 : b }");
      assertTrue(t.containsKey(1));
      assertTrue(t.containsKey(2));
      assertTrue(t.containsValue("a"));
      assertTrue(t.containsValue("b"));

      t["x"] = "c";
      t.y = "d";
      assertEquals(t.length(), 4);
      assertTrue(t.containsKey("x"));
      assertTrue(t.containsValue("c"));

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

      final m = t.asLuaMap();
      assertFalse(m.isEmpty());
      assertEquals(m.length(), 2);
      assertFalse(a.contains("x"));
      assertFalse(a.contains("y"));
      assertFalse(m.containsValue("a"));
      assertFalse(m.containsValue("b"));
      assertTrue(m.containsValue("c"));
      assertTrue(m.containsValue("d"));
   }
}
