
namespace Pulsar;

public class KeyRecord(int key, int modifier)
{
    public int Key => key;

    public int Modifier => modifier;

    public bool HasKey => key != 0;

    public bool HasModif => modifier != 0;

    private string ModToStr(int mod)
    {
        return mod switch
        {
            0xA0 => "S",
            0xA2 => "C",
            0xA4 => "A",
            _ => "",
        };
    }

    public override string ToString()
    {
        if (HasModif & HasKey)
            return $"{ModToStr(Modifier)}-{(char)Key}";
        else if (HasKey)
            return $"{(char)Key}";
        else
            return "none";
    }
}
