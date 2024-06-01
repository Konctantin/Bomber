using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;

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

    [DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

    [DllImport("dwmapi.dll")]
    static extern int DwmGetWindowAttribute(IntPtr hwnd, DWMWINDOWATTRIBUTE dwAttribute, out Rect pvAttribute, int cbAttribute);

    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);

    public IntPtr Hwd => GetForegroundWindow();

    public const int X_OFFSET = 2, Y_OFFSET = -2;

    public Rect GetForegroundRect()
    {
        var rect = new Rect();
        DwmGetWindowAttribute(Hwd, DWMWINDOWATTRIBUTE.ExtendedFrameBounds, out rect, Rect.Size);
        return rect;
    }

    public string ClassName()
    {
        var builder = new StringBuilder(500);
        var size = GetClassName(Hwd, builder, builder.Capacity);
        if (size == 0)
            return "<none>";
        return builder.ToString().Substring(0, size);
    }

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
        var rect = GetForegroundRect();

        // get left bottom pixel point
        int x = rect.Left   + X_OFFSET;
        int y = rect.Bottom + Y_OFFSET;

        var color = GetColorAt(x, y);

        return color;
    }

    public KeyRecord GetKeyFromCurrentColor()
    {
        var intColor = GetPixelColor().ToArgb();

        if (KeyMap.KEY_MAP.ContainsKey(intColor))
            return KeyMap.KEY_MAP[intColor];
        else
            return new KeyRecord(0,0);
    }
}
