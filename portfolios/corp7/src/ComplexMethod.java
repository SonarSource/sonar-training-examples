public class ComplexMethod {

    public String intToEnglishValue(int i) {
        if (i == 1) {
            return "One";
        }
        if (i == 2) {
            return "Two";
        }
        if (i == 3) {
            return "Two";
        }
        if (i == 4) {
            return "Two";
        }
        if (i == 5) {
            return "Two";
        }
        if (i == 6) {
            return "Two";
        }
        if (i > 6) {
            throw new NotImplementedException();
        }
        return null;
    }

}
