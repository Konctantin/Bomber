using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.Diagnostics;

namespace KeyBomber
{
    [StructLayout(LayoutKind.Sequential)]
    public struct Rect
    {
        public int Left;
        public int Top;
        public int Right;
        public int Bottom;
    }

    public class ForegrounWindow
    {
        [DllImport("user32.dll", SetLastError = true)]
        static extern IntPtr GetDesktopWindow();

        [DllImport("user32.dll", SetLastError = true)]
        static extern IntPtr GetWindowDC(IntPtr window);

        [DllImport("gdi32.dll", SetLastError = true)]
        static extern uint GetPixel(IntPtr dc, int x, int y);

        [DllImport("user32.dll", SetLastError = true)]
        static extern int ReleaseDC(IntPtr window, IntPtr dc);

        [DllImport("user32.dll", SetLastError = true)]
        static extern IntPtr GetForegroundWindow();

        [DllImport("user32.dll", SetLastError = true)]
        static extern IntPtr GetWindowRect(IntPtr hWnd, ref Rect rect);

        [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

        public IntPtr Hwd => GetForegroundWindow();

        public Rect GetForegroundRect()
        {
            var rect = new Rect();
            GetWindowRect(Hwd, ref rect);
            return rect;
        }

        ///Stopwatch sw = new Stopwatch();

        public string Title
        {
            get
            {
                var sb = new StringBuilder(255);
                GetWindowText(Hwd, sb, sb.Capacity);
                return sb.ToString()?.Trim();
            }
        }

        public bool IsTitle(string title, bool caseSensative = false)
        {
            var comparisonType = caseSensative ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase;
            return Title.Equals(title, comparisonType);
        }


        static Color GetColorAt(int x, int y)
        {
            var desk = GetDesktopWindow();
            var dc = GetWindowDC(desk);
            try
            {
                int color = (int)GetPixel(dc, x, y);

                int a = 0x00; // trim alpha chanel
                int r = (color >> 00) & 0xff;
                int g = (color >> 08) & 0xff;
                int b = (color >> 16) & 0xff;
                
                return Color.FromArgb(a, r, g, b);
            }
            finally
            {
                ReleaseDC(desk, dc);
            }
        }

        public Color GetPixelColor()
        {
            //sw.Restart();

            var rect = GetForegroundRect();
            var color = GetColorAt(rect.Left + 1, rect.Bottom - 1);

            //sw.Stop();
            //Console.WriteLine($"Total: {sw.Elapsed} ({sw.ElapsedMilliseconds} ms)");

            return color;
        }
    }
}
