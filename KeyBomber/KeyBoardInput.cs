using System;
using System.Runtime.InteropServices;

namespace Pulsar
{
    [Flags]
    public enum KeyEvent: uint
    {
        KeyDown   = 0x0000,
        ExtendKey = 0x0001,
        KeyUp     = 0x0002,
        ScanCode  = 0x0008,
        Unicode   = 0x0004
    }

    internal static class KeyBoardInput
    {
        private enum InputType: int
        {
            Mouse    = 0,
            KeyBoard = 1,
            Hardware = 2
        }

        private struct INPUT
        {
            public InputType type;
            public ushort wVk;
            public ushort wScan;
            public KeyEvent dwFlags;
            public uint time;
            public IntPtr dwExtraInfo;

            public static readonly int Size = Marshal.SizeOf(typeof(INPUT));
        }

        /// <summary>
        /// Synthesizes keystrokes, mouse motions, and button clicks.
        /// </summary>
        [DllImport("user32.dll")]
        private static extern uint SendInput(int nInputs, [MarshalAs(UnmanagedType.LPArray), In] INPUT[] pInputs, int cbSize);

        [DllImport("user32.dll")]
        private static extern uint MapVirtualKey(uint uCode, uint uMapType);

        public static void Send(ushort key, KeyEvent flag)
        {
            var arr = new INPUT[1] {
                new INPUT {
                    type = InputType.KeyBoard,
                    wScan = (ushort)MapVirtualKey(key, 2),
                    wVk = key,
                    dwFlags = flag,
                    time = 0,
                    dwExtraInfo = IntPtr.Zero
                }
            };

            SendInput(arr.Length, arr, INPUT.Size);
        }
    }
}
