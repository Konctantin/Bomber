using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace KeyBomber
{
    class Program
    {
        const uint WM_KEYDOWN = 0x0100;
        const uint WM_KEYUP   = 0x0101;

        [DllImport("User32.Dll", EntryPoint = "PostMessageA")]
        private static extern bool PostMessage(IntPtr hWnd, uint msg, int wParam, int lParam);

        static readonly Random random = new Random();

        private static void SendKey(IntPtr hwd, KeyRecord keyRec)
        {
            if (keyRec.HasModif)
            {
                PostMessage(hwd, WM_KEYDOWN, keyRec.Modifier, 0);
                Thread.Sleep(random.Next(10, 30));
            }

            PostMessage(hwd, WM_KEYDOWN, keyRec.Key, 0);

            Thread.Sleep(random.Next(30, 60));

            PostMessage(hwd, WM_KEYUP, keyRec.Key, 0);

            if (keyRec.HasModif)
            {
                Thread.Sleep(random.Next(10, 30));
                PostMessage(hwd, WM_KEYUP, keyRec.Modifier, 0);
            }
        }

        private static KeyRecord GetKeyFromColor(Color color)
        { 
            var intColor = color.ToArgb();

            if (KeyMap.KEY_MAP.ContainsKey(intColor))
                return KeyMap.KEY_MAP[intColor];
            else
                return new KeyRecord();
        }

        static void Main(string[] args)
        {
            //KeyMapGenerator.MakeLuaMapFiles("Bomber.KeyMap.lua");
            //KeyMapGenerator.MakeSharpMapFiles("KeyMap.cs");
            var foregroundWindow = new ForegrounWindow();

            while (true)
            {
                if (foregroundWindow.IsTitle("World of Warcraft"))
                {
                    var keyColor = foregroundWindow.GetPixelColor();
                    Console.WriteLine($"KeyColor: {keyColor}, 0x{keyColor.ToArgb():X08}");

                    var keyRec = GetKeyFromColor(keyColor);

                    Console.WriteLine(keyRec);

                    if (keyRec.HasKey)
                    {
                        //SendKey(foregroundWindow.Hwd, keyRec);
                    }
                }                

                Thread.Sleep(random.Next(800, 1200));
            }
        }
    }
}
