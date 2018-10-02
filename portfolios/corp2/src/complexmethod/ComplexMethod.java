package complexmethod;

public class ComplexMethod {

public String firstName;

    // FIXME
    public String intToEnglishValue(int i) {
        if (i == 1) {
            return "One";
        } else if (i == 3) {
            return "Three";
        }
        if (i > 3) {
            throw new NotImplementedException();
        }
        return null;
        return "OK";
    }

}
