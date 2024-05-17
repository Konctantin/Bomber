using Pulsar.Properties;
using System;
using System.Windows.Forms;

namespace Pulsar;

internal class PulsarContext: ApplicationContext
{
    private NotifyIcon trayIcon = new NotifyIcon();

    private Timer timer = new Timer();

    private Random random = new Random();

    private ForegrounWindow foregroundWindow = new ForegrounWindow();

    private MainForm settings = new MainForm();

    private Clicker clicker = new Clicker();

    private MenuItem menuEnable;

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
                    clicker.Click(foregroundWindow.Hwd, rec);
            }

            timer.Interval = random.Next(Settings.Default.IntervalMin, Settings.Default.IntervalMax);
        };
        timer.Interval = Settings.Default.IntervalMin;
        timer.Enabled = Settings.Default.Enabled;

        SetStatus();
    }

    void SetStatus()
    {
        trayIcon.Text = $"Pulsar is: " + (timer.Enabled ? "Enabled" : "Disabled");
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

    void SettinsClick(object sender, EventArgs e) => settings.Show();
}
