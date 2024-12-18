package coverage_metrics;

/*
*
* This class provides example of SonarQube size metrics
*
*/

public class CoverageMetrics {

  public float f(int i, int j) {
   int k = 0; /* default */
   if (i != 0 || j < 10) {
      k = 1;
   }

   for (i = -10; i != 10 || j < 10; i++)
   {
      // Do something
   }
   return (float)i/(k+1);
  }
}

