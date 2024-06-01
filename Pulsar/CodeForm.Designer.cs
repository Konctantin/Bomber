namespace Pulsar
{
    partial class CodeForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tpSharpMap = new System.Windows.Forms.TabPage();
            this.tpLuaMap = new System.Windows.Forms.TabPage();
            this.tbSharpCode = new System.Windows.Forms.RichTextBox();
            this.tbLuaCode = new System.Windows.Forms.RichTextBox();
            this.tabControl1.SuspendLayout();
            this.tpSharpMap.SuspendLayout();
            this.tpLuaMap.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tpSharpMap);
            this.tabControl1.Controls.Add(this.tpLuaMap);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(845, 594);
            this.tabControl1.TabIndex = 1;
            // 
            // tpSharpMap
            // 
            this.tpSharpMap.Controls.Add(this.tbSharpCode);
            this.tpSharpMap.Location = new System.Drawing.Point(4, 22);
            this.tpSharpMap.Name = "tpSharpMap";
            this.tpSharpMap.Padding = new System.Windows.Forms.Padding(3);
            this.tpSharpMap.Size = new System.Drawing.Size(669, 499);
            this.tpSharpMap.TabIndex = 0;
            this.tpSharpMap.Text = "C# Map";
            this.tpSharpMap.UseVisualStyleBackColor = true;
            // 
            // tpLuaMap
            // 
            this.tpLuaMap.Controls.Add(this.tbLuaCode);
            this.tpLuaMap.Location = new System.Drawing.Point(4, 22);
            this.tpLuaMap.Name = "tpLuaMap";
            this.tpLuaMap.Padding = new System.Windows.Forms.Padding(3);
            this.tpLuaMap.Size = new System.Drawing.Size(837, 568);
            this.tpLuaMap.TabIndex = 1;
            this.tpLuaMap.Text = "Lua Map";
            this.tpLuaMap.UseVisualStyleBackColor = true;
            // 
            // tbSharpCode
            // 
            this.tbSharpCode.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tbSharpCode.Font = new System.Drawing.Font("Courier New", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbSharpCode.Location = new System.Drawing.Point(3, 3);
            this.tbSharpCode.Name = "tbSharpCode";
            this.tbSharpCode.Size = new System.Drawing.Size(663, 493);
            this.tbSharpCode.TabIndex = 1;
            this.tbSharpCode.Text = "";
            // 
            // tbLuaCode
            // 
            this.tbLuaCode.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tbLuaCode.Font = new System.Drawing.Font("Courier New", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbLuaCode.Location = new System.Drawing.Point(3, 3);
            this.tbLuaCode.Name = "tbLuaCode";
            this.tbLuaCode.Size = new System.Drawing.Size(831, 562);
            this.tbLuaCode.TabIndex = 1;
            this.tbLuaCode.Text = "";
            // 
            // CodeForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(845, 594);
            this.Controls.Add(this.tabControl1);
            this.Name = "CodeForm";
            this.Text = "Key map generator";
            this.tabControl1.ResumeLayout(false);
            this.tpSharpMap.ResumeLayout(false);
            this.tpLuaMap.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tpSharpMap;
        private System.Windows.Forms.TabPage tpLuaMap;
        private System.Windows.Forms.RichTextBox tbSharpCode;
        private System.Windows.Forms.RichTextBox tbLuaCode;
    }
}