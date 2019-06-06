
namespace KeyBomber
{
    public class KeyRecord
    {
        public int Key { get; set; }

        public int Modifier { get; set; }

        public bool HasKey => Key != 0;

        public bool HasModif => Modifier != 0;

        public override string ToString()
        {
            return $"Modifyer: {Modifier}, Key: {Key}";
        }
    }
}
