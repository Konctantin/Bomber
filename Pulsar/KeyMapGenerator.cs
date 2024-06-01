﻿using System;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Drawing;

namespace Pulsar;

public static class KeyMapGenerator
{
    private static readonly KeysConverter keyConverter = new KeysConverter();

    private static readonly (string Name, Keys Modifier)[] Modifiers = [
        (" ", Keys.None),
        ("s", Keys.LShiftKey),
        ("c", Keys.LControlKey),
        ("a", Keys.LMenu)
    ];


    static void ForeachKeys(Action<Color, string, KeyRecord> action)
    {
        int colorOffset = 1000_000;

        foreach ((var Name, var Modifier) in Modifiers)
        {
            foreach (Keys key in Enum.GetValues(typeof(Keys)))
            {
                if (key >= Keys.D0 && key <= Keys.Z)
                {
                    colorOffset += 100_000;
                    int colorInt = colorOffset * 0xff;
                    colorInt = 0x00FFFFFF & colorInt;
                    var color = Color.FromArgb(colorInt);

                    action(color, Name, new KeyRecord((int)key, (int)Modifier));
                }
            }
        }
    }

    public static string GenerateLuaMap()
    {
        var writer = new StringBuilder();
        writer.AppendLine($"-- Autogenerated {DateTime.Now}");
        writer.AppendLine("BOMBER_KEYMAP = {");

        ForeachKeys((color, mw, keyRec) => {
            var luaKey = $"{keyConverter.ConvertToString(keyRec.Key)}";
            if (!string.IsNullOrWhiteSpace(mw))
                luaKey = $"{mw}-{keyConverter.ConvertToString(keyRec.Key)}";

            var intColor = 0x00FFFFFF & color.ToArgb();
            var luaKeyMap = $"['{luaKey.ToUpper()}'] = " +
                $"{{ " +
                $"R = 0x{color.R:X02}/255, " +
                $"G = 0x{color.G:X02}/255, " +
                $"B = 0x{color.B:X02}/255 " +
                $"}}, -- 0x{intColor:X08}";

            writer.AppendLine($"    {luaKeyMap}");
        });

        writer.AppendLine("};");

        return writer.ToString();
    }

    public static string GenerateSharpMap()
    {
        var writer = new StringBuilder();
        writer.AppendLine($"// Autogenerated {DateTime.Now}");
        writer.AppendLine("using System.Collections.Generic;");
        writer.AppendLine();
        writer.AppendLine("namespace Pulsar");
        writer.AppendLine("{");
        writer.AppendLine("    public static class KeyMap");
        writer.AppendLine("    {");
        writer.AppendLine("        public static readonly Dictionary<int, KeyRecord> KEY_MAP = new Dictionary<int, KeyRecord>");
        writer.AppendLine("        {");

        ForeachKeys((color, _, keyRec) => {
            var intColor = 0x00FFFFFF & color.ToArgb();
            var sharpKeyMap = $"[0x{intColor:X08}] = new KeyRecord(0x{keyRec.Key:X02}, 0x{keyRec.Modifier:X02}), // {keyRec}";

            writer.AppendLine($"            {sharpKeyMap}");
        });

        writer.AppendLine("        };");
        writer.AppendLine("    }");
        writer.AppendLine("}");

        return writer.ToString();
    }
}
