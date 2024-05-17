using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.Diagnostics;

namespace Pulsar;

[StructLayout(LayoutKind.Sequential)]
public struct Rect
{
    public static int Size;

    public int Left;
    public int Top;
    public int Right;
    public int Bottom;

    public override string ToString()
    {
        return $"Left: {Left} Top: {Top} Right: {Right} Bottom: {Bottom}";
    }

    static Rect()
    {
        Size = Marshal.SizeOf(typeof(Rect));
    }
}

enum DWMWINDOWATTRIBUTE : uint
{
    NCRenderingEnabled = 1,
    NCRenderingPolicy,
    TransitionsForceDisabled,
    AllowNCPaint,
    CaptionButtonBounds,
    NonClientRtlLayout,
    ForceIconicRepresentation,
    Flip3DPolicy,
    ExtendedFrameBounds,
    HasIconicBitmap,
    DisallowPeek,
    ExcludedFromPeek,
    Cloak,
    Cloaked,
    FreezeRepresentation,
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

    [DllImport("dwmapi.dll")]
    static extern int DwmGetWindowAttribute(IntPtr hwnd, DWMWINDOWATTRIBUTE dwAttribute, out Rect pvAttribute, int cbAttribute);

    public IntPtr Hwd => GetForegroundWindow();

    public const int X_OFFSET = 2, Y_OFFSET = -2;

    public Rect GetForegroundRect()
    {
        var rect = new Rect();
        DwmGetWindowAttribute(Hwd, DWMWINDOWATTRIBUTE.ExtendedFrameBounds, out rect, Rect.Size);
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

    public bool IsTitle(string title)
    {
        return Title.StartsWith(title, StringComparison.CurrentCultureIgnoreCase);
    }

    public bool IsFullScreen()
    {
        var a = GetForegroundRect();

        var b = new Rect();
        GetWindowRect(GetDesktopWindow(), ref b);

        return (a.Left   == b.Left &&
                a.Top    == b.Top &&
                a.Right  == b.Right &&
                a.Bottom == b.Bottom);
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

        // get left bottom pixel point
        int x = rect.Left   + X_OFFSET;
        int y = rect.Bottom + Y_OFFSET;

        var color = GetColorAt(x, y);

        //sw.Stop();
        //Console.WriteLine($"Total: {sw.Elapsed} ({sw.ElapsedMilliseconds} ms)");

        return color;
    }
}
