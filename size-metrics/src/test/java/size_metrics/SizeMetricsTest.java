package size_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class SizeMetricsTest {

  @Test
  public void test() throws Exception {
    SizeMetrics s = new SizeMetrics();
    assertEquals(0.0, s.f(0), 0.0);
  }
}
