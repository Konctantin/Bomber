using System.Windows.Forms;

namespace Pulsar
{
    public partial class CodeForm : Form
    {
        public CodeForm()
        {
            InitializeComponent();
        }

        public static void ShowCode()
        {
            using var form = new CodeForm();
            form.tbSharpCode.Text = KeyMapGenerator.GenerateSharpMap();
            form.tbLuaCode.Text = KeyMapGenerator.GenerateLuaMap();
            form.ShowDialog();
        }
    }
}
