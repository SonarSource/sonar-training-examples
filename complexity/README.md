# Complexity example

This example demonstrates the difference between Cognitive and Cyclomatic Complexity

The project is composed of 2 methods that do exactly the same thing,
one based on switch/case, the other based on nested ifs (purposely complicated)

Both methods have the same cyclomatic complexity (11), but
the one based on switch/case has a low cognitive complexity
while the one based on nested ifs has a very high one.

## Usage

- Make sure the Java cyclomatic complexity __and__ cognitive complexity rules are active
  in the default quality profile
- Run sonar-scanner (no need to build)

## Result

- Look at the project Training: Cyclomatic vs Cognitive complexity (key training:complexity)
- Browse to the code and look at issues
- The if based method has both an issue on cyclo and cognitive, while the switch case version only has an issue on cyclo (with same cyclo complexity of 11)
- The if based method has a 27 cognitive complexity whereas the switch/case method has only an 11.
- The if based method has a 11 cyclomatic complexity, same as the switch/case method. (both have 11 branches of execution)
