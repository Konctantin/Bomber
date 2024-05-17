namespace Pulsar
{
    partial class MainForm
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
            this.components = new System.ComponentModel.Container();
            this.gbSettings = new System.Windows.Forms.GroupBox();
            this.bApply = new System.Windows.Forms.Button();
            this.cbEnabled = new System.Windows.Forms.CheckBox();
            this.tbMax = new System.Windows.Forms.NumericUpDown();
            this.labelMax = new System.Windows.Forms.Label();
            this.tbMin = new System.Windows.Forms.NumericUpDown();
            this.labelMin = new System.Windows.Forms.Label();
            this.gbPreview = new System.Windows.Forms.GroupBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.labelKeyInfo = new System.Windows.Forms.Label();
            this.labelInfo2 = new System.Windows.Forms.Label();
            this.labelInfo1 = new System.Windows.Forms.Label();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.cbLaunchAtStartup = new System.Windows.Forms.CheckBox();
            this.gbSettings.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tbMax)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tbMin)).BeginInit();
            this.gbPreview.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // gbSettings
            // 
            this.gbSettings.Controls.Add(this.cbLaunchAtStartup);
            this.gbSettings.Controls.Add(this.bApply);
            this.gbSettings.Controls.Add(this.cbEnabled);
            this.gbSettings.Controls.Add(this.tbMax);
            this.gbSettings.Controls.Add(this.labelMax);
            this.gbSettings.Controls.Add(this.tbMin);
            this.gbSettings.Controls.Add(this.labelMin);
            this.gbSettings.Dock = System.Windows.Forms.DockStyle.Top;
            this.gbSettings.Location = new System.Drawing.Point(0, 0);
            this.gbSettings.Name = "gbSettings";
            this.gbSettings.Size = new System.Drawing.Size(486, 64);
            this.gbSettings.TabIndex = 0;
            this.gbSettings.TabStop = false;
            this.gbSettings.Text = "Settings";
            // 
            // bApply
            // 
            this.bApply.Location = new System.Drawing.Point(330, 11);
            this.bApply.Name = "bApply";
            this.bApply.Size = new System.Drawing.Size(75, 46);
            this.bApply.TabIndex = 5;
            this.bApply.Text = "Apply";
            this.bApply.UseVisualStyleBackColor = true;
            this.bApply.Click += new System.EventHandler(this.bApply_Click);
            // 
            // cbEnabled
            // 
            this.cbEnabled.AutoSize = true;
            this.cbEnabled.Location = new System.Drawing.Point(12, 14);
            this.cbEnabled.Name = "cbEnabled";
            this.cbEnabled.Size = new System.Drawing.Size(65, 17);
            this.cbEnabled.TabIndex = 4;
            this.cbEnabled.Text = "Enabled";
            this.cbEnabled.UseVisualStyleBackColor = true;
            // 
            // tbMax
            // 
            this.tbMax.Location = new System.Drawing.Point(235, 37);
            this.tbMax.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.tbMax.Minimum = new decimal(new int[] {
            15,
            0,
            0,
            0});
            this.tbMax.Name = "tbMax";
            this.tbMax.Size = new System.Drawing.Size(79, 20);
            this.tbMax.TabIndex = 3;
            this.tbMax.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.tbMax.Value = new decimal(new int[] {
            15,
            0,
            0,
            0});
            // 
            // labelMax
            // 
            this.labelMax.AutoSize = true;
            this.labelMax.Location = new System.Drawing.Point(140, 42);
            this.labelMax.Name = "labelMax";
            this.labelMax.Size = new System.Drawing.Size(89, 13);
            this.labelMax.TabIndex = 2;
            this.labelMax.Text = "Max interval (ms):";
            // 
            // tbMin
            // 
            this.tbMin.Location = new System.Drawing.Point(235, 11);
            this.tbMin.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.tbMin.Minimum = new decimal(new int[] {
            15,
            0,
            0,
            0});
            this.tbMin.Name = "tbMin";
            this.tbMin.Size = new System.Drawing.Size(79, 20);
            this.tbMin.TabIndex = 1;
            this.tbMin.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.tbMin.Value = new decimal(new int[] {
            15,
            0,
            0,
            0});
            // 
            // labelMin
            // 
            this.labelMin.AutoSize = true;
            this.labelMin.Location = new System.Drawing.Point(141, 13);
            this.labelMin.Name = "labelMin";
            this.labelMin.Size = new System.Drawing.Size(86, 13);
            this.labelMin.TabIndex = 0;
            this.labelMin.Text = "Min interval (ms):";
            // 
            // gbPreview
            // 
            this.gbPreview.Controls.Add(this.pictureBox1);
            this.gbPreview.Controls.Add(this.panel1);
            this.gbPreview.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gbPreview.Location = new System.Drawing.Point(0, 64);
            this.gbPreview.Name = "gbPreview";
            this.gbPreview.Size = new System.Drawing.Size(486, 428);
            this.gbPreview.TabIndex = 1;
            this.gbPreview.TabStop = false;
            this.gbPreview.Text = "Info";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pictureBox1.Location = new System.Drawing.Point(3, 74);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(480, 351);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 4;
            this.pictureBox1.TabStop = false;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.labelKeyInfo);
            this.panel1.Controls.Add(this.labelInfo2);
            this.panel1.Controls.Add(this.labelInfo1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(3, 16);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(480, 58);
            this.panel1.TabIndex = 3;
            // 
            // labelKeyInfo
            // 
            this.labelKeyInfo.AutoSize = true;
            this.labelKeyInfo.Location = new System.Drawing.Point(3, 42);
            this.labelKeyInfo.Name = "labelKeyInfo";
            this.labelKeyInfo.Size = new System.Drawing.Size(45, 13);
            this.labelKeyInfo.TabIndex = 2;
            this.labelKeyInfo.Text = "Key info";
            // 
            // labelInfo2
            // 
            this.labelInfo2.AutoSize = true;
            this.labelInfo2.Location = new System.Drawing.Point(4, 24);
            this.labelInfo2.Name = "labelInfo2";
            this.labelInfo2.Size = new System.Drawing.Size(35, 13);
            this.labelInfo2.TabIndex = 1;
            this.labelInfo2.Text = "label3";
            // 
            // labelInfo1
            // 
            this.labelInfo1.AutoSize = true;
            this.labelInfo1.Location = new System.Drawing.Point(4, 4);
            this.labelInfo1.Name = "labelInfo1";
            this.labelInfo1.Size = new System.Drawing.Size(35, 13);
            this.labelInfo1.TabIndex = 0;
            this.labelInfo1.Text = "label4";
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // cbLaunchAtStartup
            // 
            this.cbLaunchAtStartup.AutoSize = true;
            this.cbLaunchAtStartup.Location = new System.Drawing.Point(12, 38);
            this.cbLaunchAtStartup.Name = "cbLaunchAtStartup";
            this.cbLaunchAtStartup.Size = new System.Drawing.Size(109, 17);
            this.cbLaunchAtStartup.TabIndex = 6;
            this.cbLaunchAtStartup.Text = "Launch at startup";
            this.cbLaunchAtStartup.UseVisualStyleBackColor = true;
            this.cbLaunchAtStartup.CheckedChanged += new System.EventHandler(this.cbLaunchAtStartup_CheckedChanged);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(486, 492);
            this.Controls.Add(this.gbPreview);
            this.Controls.Add(this.gbSettings);
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Pulsar";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.MainForm_FormClosing);
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.gbSettings.ResumeLayout(false);
            this.gbSettings.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tbMax)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tbMin)).EndInit();
            this.gbPreview.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbSettings;
        private System.Windows.Forms.CheckBox cbEnabled;
        private System.Windows.Forms.NumericUpDown tbMax;
        private System.Windows.Forms.Label labelMax;
        private System.Windows.Forms.NumericUpDown tbMin;
        private System.Windows.Forms.Label labelMin;
        private System.Windows.Forms.GroupBox gbPreview;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label labelInfo2;
        private System.Windows.Forms.Label labelInfo1;
        private System.Windows.Forms.Button bApply;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Label labelKeyInfo;
        private System.Windows.Forms.CheckBox cbLaunchAtStartup;
    }
}