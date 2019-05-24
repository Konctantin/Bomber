using System;
using System.Collections.Generic;
using System.Drawing;
using System.Runtime.InteropServices;
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

        //private static Bitmap CropImage(Bitmap img, Rectangle cropArea)
        //{
        //    var bmpImage = new Bitmap(img);
        //    return bmpImage.Clone(cropArea, bmpImage.PixelFormat);
        //}

        private static void SendAKey(IntPtr hwd, int key, int mod = 0)
        {
            if (mod != 0)
            {
                PostMessage(hwd, WM_KEYDOWN, mod, 0);
                Thread.Sleep(random.Next(10, 30));
            }

            PostMessage(hwd, WM_KEYDOWN, key, 0);

            Thread.Sleep(random.Next(30, 60));

            PostMessage(hwd, WM_KEYUP, key, 0);

            if (mod != 0)
            {
                Thread.Sleep(random.Next(10, 30));
                PostMessage(hwd, WM_KEYUP, mod, 0);
            }
        }

        private static int GetKeyFromColor(Color color)
        {
            return 0;
        }

        private static int GetModFromColor(Color color)
        {
            return 0;
        }

        static void Main(string[] args)
        {
            var foregroundWindow = new ForegrounWindow();

            while (true)
            {
                if (foregroundWindow.IsTitle("World of Warcraft"))
                {
                    var image = foregroundWindow.GetScreen();
                    //var modKeyImg = CropImage(image, new Rectangle(0, 0, 10, 10));
                    //var keyImg    = CropImage(image, new Rectangle(10, 0, 10, 10));

                    var modColor = image.GetPixel(5,  5);
                    var keyColor = image.GetPixel(15, 5);
                    Console.WriteLine($"ModColor: {modColor}, KeyColor: {keyColor}");

                    var key = GetKeyFromColor(keyColor);
                    var mod = GetModFromColor(modColor);

                    Console.WriteLine($"Modifier: {mod}, Key: {key}");

                    if (key != 0 && mod != 0)
                    {
                        SendAKey(foregroundWindow.Hwd, key, mod);
                    }
                }
                

                Thread.Sleep(random.Next(80, 120));
            }
        }
    }
}
