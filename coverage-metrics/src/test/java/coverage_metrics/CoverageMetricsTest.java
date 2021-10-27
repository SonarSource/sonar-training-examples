package coverage_metrics;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class CoverageMetricsTest {
  @Test
  public void test1() throws Exception {
    // This test covers all the lines of the c.f() method BUT
    // does not cover all the conditions. Running that test alone
    // yields a 100% (6/6) line coverage BUT only a 50% (1/2) condition coverage
    // This produces an overall coverage of (6+1)/(6+2)=87% overall coverage
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.5, c.f(1), 0.0);
  }

  @Test
  public void test2() throws Exception {
    // This 2nd test covers the 2nd condition to achieve (combined with test1)
    // a 100% line coverage and 100% condition coverage, therefore a
    // 100% overall coverage
    CoverageMetrics c = new CoverageMetrics();
    assertEquals(0.0, c.f(0), 0.0);
  }

  @Test
  public void test3() {
    CoverageMetrics c = new CoverageMetrics();
    // The below line is an incorrect test: Method c.f() is invoked
    // but the returned value is not verified to be as expected
    // SonarQube will raise an issue for lack of assertion
    float x = c.f(5);
  }
}
