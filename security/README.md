# Security

## Use case
This example demonstrates:
- Vulnerabilities found by the taint analysis engine (`javasecurity:*` rules)
- Review-style security findings such as weak cryptography, insecure cookies and unsafe temp files

Note that SonarQube no longer has a separate "Security Hotspot" category; what used to be raised
as hotspots is now raised as regular issues with a security impact.

It also demonstrates the possibility to define your own custom sources, validators and sinks to detect more injection cases
(or avoid false positives)

## Usage

Run `./run.sh`

This will:
- Delete the project key **training:security** if it exists in SonarQube (to start from a scratch)
- Run `mvn clean verify sonar:sonar` to re-create the project

Project consists of a single class (`training.security.Insecure`, in `src/main/java/training/security/Insecure.java`) with a number of Vulnerabilities and Security Hotspots.

## Custom security configuration 
At the bottom of the class you see a bunch of methods that demonstrate custom injections.
- The method without sanitization (`doSomething()`) has an injection vulnerability
- The method with custom sanitization (`doSomethingSanitized()`) has no vulnerability

The custom security configuration file is in the root directory [here](s3649JavaSqlInjectionConfig.json)

`verifyData()` returns `void` and validates its argument in place, so it is declared under the
`validators` key and passed through `sonar.security.validators.javasecurity.S3649`. The
`sanitizers` key is for methods that *return* a cleaned value. Declaring an in-place check as a
sanitizer loads without error but has no effect, so the sanitized method would still be flagged.

`run.sh` passes these as scanner properties, which the analyzer reports as deprecated. They still
work; the recommended alternative is to set the same properties at server or project level under
**Project Settings > General Settings > Security Engine Custom Configuration**.
