using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace KeyBomber
{
    public class ForegrounWindow
    {
        [StructLayout(LayoutKind.Sequential)]
        private struct Rect
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        [DllImport("user32.dll")]
        private static extern IntPtr GetForegroundWindow();

        [DllImport("user32.dll")]
        private static extern IntPtr GetWindowRect(IntPtr hWnd, ref Rect rect);


        [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

        public IntPtr Hwd => GetForegroundWindow();

        public string Title
        {
            get
            {
                var sb = new StringBuilder(255);
                GetWindowText(GetForegroundWindow(), sb, sb.Capacity);
                return sb.ToString()?.Trim();
            }
        }

        public bool IsTitle(string title, bool caseSensative = false)
        {
            return Title.Equals(title, caseSensative ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase);
        }

        public Bitmap GetScreen()
        {
            var rect = new Rect();
            GetWindowRect(GetForegroundWindow(), ref rect);

            var bounds = new Rectangle(rect.Left, rect.Bottom - 10, 20, 10);
            var result = new Bitmap(bounds.Width, bounds.Height);

            using (var g = Graphics.FromImage(result))
            {
                g.CopyFromScreen(new Point(bounds.Left, bounds.Top), Point.Empty, bounds.Size);
            }

            return result;
        }
    }
}
