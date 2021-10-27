package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CoverageMetricsTest {
  @Test
  public void test3() {
    CoverageMetrics c = new CoverageMetrics();
    // The below line is an incorrect test: Method c.f() is invoked
    // but the returned value is not verified to be as expected
    // SonarQube will raise an issue for lack of assertion
    float x = c.f(5);
  }
}
