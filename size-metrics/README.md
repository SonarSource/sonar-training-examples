# Size Metrics

This example demonstrates the different size metrics (lines, LoC, Comment lines, comment %), lines to cover, conditions to cover

## Usage

Run `build.sh [<optional_analysis_properties>]`

The `build.sh` script takes care of building and analyzing the project
It runs:
```
mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install sonar:sonar [<optional_analysis_properties>]
```

## Result

The build command will create a project named **Training: Size Metrics** (key `training:size-metrics`) where you can witness the resulting size metrics
