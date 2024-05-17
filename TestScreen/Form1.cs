using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using KeyBomber;

namespace TestScreen
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            //pictureBox1.Image
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            try
            {
                var fg = new ForegrounWindow();
                if (!fg.IsTitle("World of Warcraft"))
                    return;

                var rect = fg.GetForegroundRect();

                label1.Text = $"Rect: Left:{rect.Left} Top: {rect.Top} Right: {rect.Right} Bottom:{rect.Bottom} + {fg.ClassName()}";


                using (Bitmap bmp = new Bitmap(rect.Right-rect.Left, rect.Bottom-rect.Top))
                using (Graphics g = Graphics.FromImage(bmp))
                {
                    g.CopyFromScreen(rect.Left, rect.Top, 0, 0, bmp.Size);

                    g.DrawRectangle(new Pen(Color.Aqua, 1), 0, bmp.Height - 5, 5, 5);
                    

                    g.FillRectangle(Brushes.Cyan, 2, bmp.Height - 2, 1,1);

                    if (pictureBox1.Image != null)
                        pictureBox1.Image.Dispose();

                    var r = new Rectangle(0, bmp.Height-300, 300, 300);
                    label2.Text = $"Rect: {r}";

                    pictureBox1.Image = bmp.Clone(r, System.Drawing.Imaging.PixelFormat.DontCare);
                }
            }
            catch (Exception ex)
            {
                label2.Text = ex.Message;
                //timer1.Enabled = false;
                //MessageBox.Show(ex.Message);
            }
        }
    }
}
