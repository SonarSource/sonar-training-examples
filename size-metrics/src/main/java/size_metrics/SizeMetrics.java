package size_metrics;

/*
*
* This class provides example of SonarQube size metrics
*
*/

public class SizeMetrics {

  public float f(int i) {
   int k = 0; /* default */
   if (i != 0) {
      k = 1;
   }
   return (float)i/(k+1);
  }
}
