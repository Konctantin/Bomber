using System.Windows.Forms;

namespace Pulsar
{
    public partial class CodeForm : Form
    {
        public CodeForm()
        {
            InitializeComponent();
        }

        public static void ShowCode(string code, string title)
        {
            using var form = new CodeForm();
            form.Text = title;
            form.richTextBox1.Text = code;
            form.ShowDialog();
        }
    }
}
