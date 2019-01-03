package coverage_metrics;

/*
*
* This class provides example of SonarQube size metrics
*
*/

public class CoverageMetrics {

  public float f(int i) {
   int k = 0; /* default */
   if (i != 0) {
      k = 1;
   }
   return (float)i/(k+1);
  }

  public void doSomethingStupid(int max) {
    int i;
    float x;
    for (i = 0; i > max; i++) {
      x = f(i);
    }
  }
}
