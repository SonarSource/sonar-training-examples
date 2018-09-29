package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CoverageMetricsTest {
  @Test
  public void test1() throws Exception {
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.5, c.f(1), 0.0);
  }

  @Test
  public void test2() throws Exception {
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.0, c.f(0), 0.0);
  }

  @Test
  public void test3() {
    CoverageMetrics c = new CoverageMetrics();
    float x = c.f(5);
  }
}
