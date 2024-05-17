using System;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace Pulsar;

internal class Clicker
{
    const uint WM_KEYDOWN = 0x0100;
    const uint WM_KEYUP = 0x0101;
    const int VK_MENU = 0x12; // alt

    [DllImport("user32.dll", EntryPoint = "PostMessageA", SetLastError = true)]
    private static extern bool PostMessage(IntPtr hWnd, uint msg, int wParam, int lParam);

    [DllImport("user32.dll", SetLastError = true)]
    private static extern ushort GetKeyState(int nVirtKey);

    static readonly Random random = new Random();

    bool started = false;

    public void Click(IntPtr hwd, KeyRecord key)
    {
        if (started)
            return;

        if (IsAltKeyDown())
            return;

        started = true;
        Task.Factory.StartNew(() => {
            SendKey(hwd, key);
            started = false;
        });
    }

    private bool IsAltKeyDown()
    {
        var state = GetKeyState(VK_MENU);
        return (state & 0xFF00) == 0xFF00;
    }

    private void RandomSleep(int min, int max)
    {
        Thread.Sleep(random.Next(min, max));
    }

    private void SendKey(IntPtr hwd, KeyRecord keyRec)
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
}
