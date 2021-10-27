package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CoverageMetricsTest {
  @Test
  public void test2() throws Exception {
    // This 2nd test alone covers only 4 out of 5 lines (so line coverage is 80%)
    // and 1 out of 2 conditions (so condition coverage is 50%)
    // The overall coverage is (4+1)/(5+2) = 71.4%
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.0, c.f(0), 0.0);
  }

}
