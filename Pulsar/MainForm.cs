using Pulsar.Properties;
using System;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.Win32;

namespace Pulsar
{
    public partial class MainForm : Form
    {
        const string AppName = "Pulsar";

        const string p = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run";
        RegistryKey registryRunKey = Registry.CurrentUser.OpenSubKey(p, true);

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            e.Cancel = true;
            this.Hide();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            try
            {
                var window = new ForegrounWindow();
                if (!window.IsTitle("World of Warcraft"))
                    return;

                var winRect = window.GetForegroundRect();

                labelInfo1.Text = $"Rect: Left:{winRect.Left} Top: {winRect.Top} " +
                    $"Right: {winRect.Right} Bottom:{winRect.Bottom} " +
                    $"+ {window.ClassName()}";

                using var bmp = new Bitmap(winRect.Right - winRect.Left, winRect.Bottom - winRect.Top);
                using var g = Graphics.FromImage(bmp);
                g.CopyFromScreen(winRect.Left, winRect.Top, 0, 0, bmp.Size);
                g.DrawRectangle(new Pen(Color.Aqua, 1), 0, bmp.Height - 5, 5, 5);
                g.FillRectangle(Brushes.Cyan, 2, bmp.Height - 2, 1, 1);

                var r = new Rectangle(0, bmp.Height - 300, 300, 300);
                labelInfo2.Text = $"Rect: {r}";

                pictureBox1.Image?.Dispose();
                pictureBox1.Image = bmp.Clone(r, System.Drawing.Imaging.PixelFormat.DontCare);

                var pix = window.GetPixelColor();
                var keyRec = window.GetKeyFromCurrentColor();
                labelKeyInfo.Text = $"KeyInfo: {DateTime.Now:HH:mm:ss.fff} KeyColor: 0x{pix.ToArgb():X08} HotKey: <{keyRec}>";
            }
            catch (Exception ex)
            {
                labelInfo2.Text = ex.Message;
            }
        }

        private void bApply_Click(object sender, EventArgs e)
        {
            Settings.Default.Save();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            cbLaunchAtStartup.Checked = !string.IsNullOrEmpty(registryRunKey.GetValue(AppName)?.ToString());

            cbEnabled.DataBindings.Add("Checked",
                Settings.Default, "Enabled",
                true,
                DataSourceUpdateMode.OnPropertyChanged);

            tbMin.DataBindings.Add("Value",
                Settings.Default, "IntervalMin",
                true,
                DataSourceUpdateMode.OnPropertyChanged);

            tbMax.DataBindings.Add("Value",
                Settings.Default, "IntervalMax",
                true,
                DataSourceUpdateMode.OnPropertyChanged);

            tbMin.DataBindings.Add("Maximum",
                Settings.Default, "IntervalMax",
                true,
                DataSourceUpdateMode.OnPropertyChanged);

            tbMax.DataBindings.Add("Minimum",
                Settings.Default, "IntervalMin",
                true,
                DataSourceUpdateMode.OnPropertyChanged);
        }

        private void cbLaunchAtStartup_CheckedChanged(object sender, EventArgs e)
        {
            registryRunKey.DeleteValue(AppName, false);
            if (cbLaunchAtStartup.Checked)
                registryRunKey.SetValue(AppName, Application.ExecutablePath);
        }
    }
}
