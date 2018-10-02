package complexmethod;

public class ComplexMethod {

    public String intToEnglishValue(int i) {
        if (i == 1) {
            return "One";
        } else if (i == 2) {
            return "Two";
        }
        if (i > 3) {
            throw new NotImplementedException();
        }
        return null;
    }

}
