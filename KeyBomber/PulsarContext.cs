using KeyBomber;
using Pulsar.Properties;
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Pulsar;

internal class PulsarContext: ApplicationContext
{
    const uint WM_KEYDOWN = 0x0100;
    const uint WM_KEYUP = 0x0101;
    const int VK_MENU = 0x12; // alt

    [DllImport("user32.dll", EntryPoint = "PostMessageA", SetLastError = true)]
    private static extern bool PostMessage(IntPtr hWnd, uint msg, int wParam, int lParam);

    [DllImport("user32.dll", SetLastError = true)]
    private static extern ushort GetKeyState(int nVirtKey);

    private NotifyIcon trayIcon;

    private System.Windows.Forms.Timer timer = new System.Windows.Forms.Timer();

    private Random random = new Random();

    private ForegrounWindow foregroundWindow = new ForegrounWindow();

    private Action action;

    private MainForm settings = new MainForm();

    public PulsarContext()
    {
        Settings.Default.PropertyChanged += Default_PropertyChanged;

        timer.Tick += (o, e) => {
            if (!IsAltKeyDown() && foregroundWindow.IsTitle("World of Warcraft"))
            {
                var keyColor = foregroundWindow.GetPixelColor();
                var keyRec = GetKeyFromColor(keyColor);
                if (keyRec.HasKey)
                {
                    //Console.WriteLine($"{DateTime.Now:HH:mm:ss.fff} KeyColor: 0x{keyColor.ToArgb():X08} HotKey: <{keyRec}>");
                    Task.Factory.StartNew(new Action(() => SendKey(foregroundWindow.Hwd, keyRec)));
                }
            }

            timer.Interval = random.Next(Settings.Default.IntervalMin, Settings.Default.IntervalMax);
        };

        timer.Interval = Settings.Default.IntervalMin;

        // Initialize Tray Icon
        trayIcon = new NotifyIcon()
        {
            Icon = Resources.TrayIcon,
            ContextMenu = new ContextMenu(new MenuItem[] {
                new MenuItem("Play/Pause", PlayPauseClick),
                new MenuItem("Settings", SettinsClick),
                new MenuItem("Exit", ExitClick)
            }),
            Visible = true
        };

        trayIcon.DoubleClick += (o, e) => {

        };
    }

    private void Default_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
    {
   

        //throw new NotImplementedException();
    }

    private static bool IsAltKeyDown()
    {
        var state = GetKeyState(VK_MENU);
        //Console.WriteLine($"0x{state:X04}");
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

    private KeyRecord GetKeyFromColor(Color color)
    {
        var intColor = color.ToArgb();

        if (KeyMap.KEY_MAP.ContainsKey(intColor))
            return KeyMap.KEY_MAP[intColor];
        else
            return new KeyRecord();
    }

    void ExitClick(object sender, EventArgs e)
    {
        trayIcon.Visible = false;
        Application.Exit();
    }

    void PlayPauseClick(object sender, EventArgs e)
    {
        // todo: change icon
        timer.Enabled = !timer.Enabled;
    }

    void SettinsClick(object sender, EventArgs e)
    {
        settings.Show();
    }
}
