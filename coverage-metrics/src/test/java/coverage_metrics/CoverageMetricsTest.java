package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CoverageMetricsTest {
  @Test
  public void test1() throws Exception {
    // This test covers all the lines of the c.f() method BUT
    // does not cover all the conditions. Running that test alone
    // yields a 100% (5/5) line coverage BUT only a 50% (1/2) condition coverage
    // This produces an overall coverage of (5+1)/(5+2)=85.7% overall coverage
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.5, c.f(1), 0.0);
  }
}
