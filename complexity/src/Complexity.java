public class Complexity extends Object {

   public static void highCycloLowCognitive(int i)
   {
      switch (i) {
         case 1:
            doSomething();
            break;
         case 2:
            doSomethingElse();
            break;
         case 3:
            forgetIt();
            break;
         case 4:
            forgetItAgain();
            break;
         case 5:
            yetAnotherCase();
            break;
         case 6:
            soBoring();
            break;
         case 7:
            timeForVacations();
            break;
         case 8:
            eightCase();
            break;
         case 9:
            cantSeeTheEndOfIt();
            break;
         case 10:
            tenThisIsIt();
            break;
         default:
            doNothing();
            break;
      }
      return;
   }

   public static void highCycloVeryHighCognitive(int i)
   {
      if ( i <= 5 ) {
         if ( i <= 2 ) {
            if ( i == 1 ) {
               doSomething();
            } else {
               doSomethingElse();
            }
         } else {   
            if ( i > 3 ) {
               forgetItAgain();
            } else {
               forgetIt();
            }
         }
      } else {
         if ( i <= 7 ) {
            if ( i == 6 ) {
               soBoring();
            } else if ( i == 7 ) {
               timeForVacations();
            } else {
               // Never reached
               doNothing();
            } 
         } else {
            if ( i == 8 ) {
               eightCase();
            } else if ( i == 9 ) {
               cantSeeTheEndOfIt();
            } else if ( i == 10 ) {
               tenThisIsIt();
            } else {
               doNothing();
            }
         }
      }
   }
}

