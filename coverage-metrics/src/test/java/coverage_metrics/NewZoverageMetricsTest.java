package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class NewZoverageMetricsTest {
  @Test
  public void test1() throws Exception {
    NewZoverageMetrics c = new NewZoverageMetrics();
    assertEquals(0.5, c.f(1), 0.0);
  }

  @Test
  public void test2() throws Exception {
    NewZoverageMetrics c = new NewZoverageMetrics();
    assertEquals(0.0, c.f(0), 0.0);
  }

  @Test
  public void test3() {
    NewZoverageMetrics c = new NewZoverageMetrics();
    float x = c.f(5);
  }
}
