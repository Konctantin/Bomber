using Pulsar.Properties;
using System;
using System.Windows.Forms;

namespace Pulsar;

internal class PulsarContext: ApplicationContext
{
    private readonly NotifyIcon trayIcon = new ();

    private readonly Timer timer = new ();

    private readonly Random random = new ();

    private readonly ForegrounWindow foregroundWindow = new ();

    private readonly Clicker clicker = new();

    private readonly MenuItem menuEnable;

    private MainForm settings;

    private string lastKey = "";

    public PulsarContext()
    {
        // detect setting changes
        Settings.Default.PropertyChanged += (o, e) => {
            if (e.PropertyName == "Enabled")
            {
                timer.Enabled = Settings.Default.Enabled;
                SetStatus();
            }
        };

        // setup tray
        menuEnable = new MenuItem("Enable/Disable", PlayPauseClick);
        trayIcon.ContextMenu = new ContextMenu([
            menuEnable,
            new MenuItem("Settings", SettinsClick),
            new MenuItem("Exit", ExitClick)
        ]);
        trayIcon.ContextMenu.Popup += (o, e) => {
            menuEnable.Text = timer.Enabled ? "Disable" : "Enable";
        };
        trayIcon.DoubleClick += SettinsClick;
        trayIcon.Visible = true;

        // setup timer
        timer.Tick += (o, e) => {
            if (foregroundWindow.IsTitle("World of Warcraft"))
            {
                var rec = foregroundWindow.GetKeyFromCurrentColor();
                if (rec.HasKey)
                {
                    lastKey = rec.ToString();
                    clicker.Click(foregroundWindow.Hwd, rec);
                }
            }

            timer.Interval = random.Next(Settings.Default.IntervalMin, Settings.Default.IntervalMax);
            SetStatus();
        };
        timer.Interval = Settings.Default.IntervalMin;
        timer.Enabled = Settings.Default.Enabled;

        SetStatus();
    }

    void SetStatus()
    {
        trayIcon.Text = $"Pulsar " + (timer.Enabled ? "Enabled" : "Disabled")
            + "\r\n"
            + "Interval: " + timer.Interval
            + "\r\n"
            + "Last Key: " + lastKey;
        trayIcon.Icon = timer.Enabled ? Resources.StatusEnabled : Resources.StatusDisabled;
    }

    void ExitClick(object sender, EventArgs e)
    {
        trayIcon.Visible = false;
        Application.Exit();
    }

    void PlayPauseClick(object sender, EventArgs e)
    {
        timer.Enabled = !timer.Enabled;
        SetStatus();
    }

    void SettinsClick(object sender, EventArgs e)
    {
        if (settings?.IsDisposed != false)
            settings = new MainForm();
        settings.Show();
    }
}
