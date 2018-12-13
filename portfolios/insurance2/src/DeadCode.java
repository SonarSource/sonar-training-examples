public class DeadCode extends Object {

   boolean isThereDeadCode(boolean a) {
      boolean b = ! a;
      if (a && b) {
         int k = 5;
         k = k + (b ? 6 : 19);
         return (k > 15);
      } else {
         return false;
      }
   }

   public void checkForDeadCode()
   {
      isThereDeadCodeAgain(3);
      isThereDeadCodeAgain(30);
      isThereDeadCodeAgain(187);
      isThereDeadCodeAgain(42);
   }

   private boolean isThereDeadCodeAgain(int i) {
      int k = 5;
      if (i > 0) {
         return true;
      } else {
         k = k * i;
         return (k > 42);
      }
   }

   private boolean mmmhIsThisDead(int i) {
      int k = i * 5;
      return (k > 42 ? true : false);
   }
}

