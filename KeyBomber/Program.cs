using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Linq;
using System.Threading;

namespace KeyBomber
{
    class Program
    {
        const uint WM_KEYDOWN = 0x0100;
        const uint WM_KEYUP   = 0x0101;
        const int VK_MENU     = 0x12; // alt

        [DllImport("user32.dll", EntryPoint = "PostMessageA", SetLastError = true)]
        private static extern bool PostMessage(IntPtr hWnd, uint msg, int wParam, int lParam);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern ushort GetKeyState(int nVirtKey);

        static readonly Random random = new Random();

        private static void RandomSleep(int min, int max)
        {
            Thread.Sleep(random.Next(min, max));
        }

        private static bool IsAltKeyDown()
        {
            var state = GetKeyState(VK_MENU);
            //Console.WriteLine($"0x{state:X04}");
            return (state & 0xFF00) == 0xFF00;
        }

        private static void SendKey(IntPtr hwd, KeyRecord keyRec)
        {
            if (keyRec.HasModif)
            {
                PostMessage(hwd, WM_KEYDOWN, keyRec.Modifier, 0);
                RandomSleep(10, 30);
            }

            int count = random.Next(1, 2);
            for (int i = 0; i < count; ++i)
            {
                if (i > 0)
                {
                    RandomSleep(10, 30);
                }

                PostMessage(hwd, WM_KEYDOWN, keyRec.Key, 0);
                RandomSleep(30, 60);
                PostMessage(hwd, WM_KEYUP, keyRec.Key, 0);
            }

            if (keyRec.HasModif)
            {
                RandomSleep(10, 30);
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
            if (args.Contains("-m"))
            {
                KeyMapGenerator.MakeLuaMapFiles("Bomber.KeyMap.lua");
                KeyMapGenerator.MakeSharpMapFiles("KeyMap.cs");
                Console.ReadLine();
            }
            else if (args.Contains("-t"))
            {
                // delay for select window
                Thread.Sleep(2_000);
                // test: SendInput
                KeyBoardInput.Send(40, KeyEvent.KeyDown);
                Thread.Sleep(50);
                KeyBoardInput.Send(40, KeyEvent.KeyUp);
            }
            else
            {
                var foregroundWindow = new ForegrounWindow();

                while (true)
                {
                    if (IsAltKeyDown())
                    {
                        // pause
                    }
                    else if (foregroundWindow.IsTitle("World of Warcraft"))
                    {
                        var keyColor = foregroundWindow.GetPixelColor();
                        var keyRec = GetKeyFromColor(keyColor);
                        if (keyRec.HasKey)
                        {
                            Console.WriteLine($"{DateTime.Now:HH:mm:ss.fff} KeyColor: 0x{keyColor.ToArgb():X08} HotKey: <{keyRec}>");
                            SendKey(foregroundWindow.Hwd, keyRec);
                        }
                    }

                    Thread.Sleep(100);
                }
            }
        }
    }
}
