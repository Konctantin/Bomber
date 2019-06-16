﻿using System;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Drawing;

namespace KeyBomber
{
    public static class KeyMapGenerator
    {
        static readonly KeysConverter keyConverter = new KeysConverter();

        static readonly (string Name, Keys Modifier)[] Modifiers = {
            (" ", Keys.None),
            ("s", Keys.LShiftKey),
            ("c", Keys.LControlKey),
            ("a", Keys.LMenu)
        };

        public static void MakeLuaMapFiles(string fileName)
        {
            using (var writer = new StreamWriter(fileName, false, Encoding.UTF8))
            {
                writer.WriteLine("BOMBER_KEYMAP = {");

                ForeachKeys((c, mw, k) => {
                    var luaKey = $"{keyConverter.ConvertToString(k.Key)}";
                    if (!string.IsNullOrWhiteSpace(mw))
                        luaKey = $"{mw}-{keyConverter.ConvertToString(k.Key)}";

                    var luaKeyMap = $"['{luaKey.ToUpper()}'] = {{ R = 0x{c.R:X02}/255, G = 0x{c.G:X02}/255, B = 0x{c.B:X02}/255 }},";

                    writer.WriteLine($"    {luaKeyMap}");
                });

                writer.WriteLine("};");
            }
        }

        public static void MakeSharpMapFiles(string fileName)
        {
            using (var writer = new StreamWriter(fileName, false, Encoding.UTF8))
            {
                writer.WriteLine("using System.Collections.Generic;");
                writer.WriteLine();
                writer.WriteLine("namespace KeyBomber");
                writer.WriteLine("{");
                writer.WriteLine("    public static class KeyMap");
                writer.WriteLine("    {");
                writer.WriteLine("        public static readonly Dictionary<int, KeyRecord> KEY_MAP = new Dictionary<int, KeyRecord>");
                writer.WriteLine("        {");

                ForeachKeys((c, mw, k) => {
                    var intColor = 0x00FFFFFF & c.ToArgb();
                    var sharpKeyMap = $"[0x{intColor:X08}] = new KeyRecord {{ Key = 0x{k.Key:X02}, Modifier = 0x{k.Modifier:X02} }},";

                    writer.WriteLine($"            {sharpKeyMap}");
                });

                writer.WriteLine("        };");
                writer.WriteLine("    }");
                writer.WriteLine("}");
            }
        }

        static void ForeachKeys(Action<Color, string, KeyRecord> action)
        {
            int colorOffset = 1000_000;
            var keyConverter = new KeysConverter();

            foreach (var mod in Modifiers)
            {
                foreach (Keys key in Enum.GetValues(typeof(Keys)))
                {
                    if ((key >= Keys.A && key <= Keys.Z) || (key >= Keys.D0 && key <= Keys.D9))
                    {
                        colorOffset += 100_000;
                        int colorInt = colorOffset * 0xff;
                        colorInt = 0x00FFFFFF & colorInt;
                        var color = Color.FromArgb(colorInt);

                        action(color, mod.Name, new KeyRecord { Key = (int)key, Modifier = (int)mod.Modifier });
                    }
                }
            }
        }
    }
}