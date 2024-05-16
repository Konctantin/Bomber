
namespace Pulsar
{
    public class KeyRecord
    {
        public int Key { get; set; }

        public int Modifier { get; set; }

        public bool HasKey => Key != 0;

        public bool HasModif => Modifier != 0;

        private string ModToStr(int mod)
        {
            switch (mod)
            {
                case 0xA0: return "S";
                case 0xA2: return "C";
                case 0xA4: return "A";
                default: return "";
            }
        }

        public override string ToString()
        {
            if (HasModif)
                return $"{ModToStr(Modifier)}-{(char)Key}";
            else
                return $"{(char)Key}";
        }
    }
}
