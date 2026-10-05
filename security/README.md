# Security

## Use case
This example demonstrates:
- Injection findings from the taint analysis engine (`javasecurity:*` rules)
- Review-style security findings such as weak cryptography, insecure cookies and unsafe temp files

Every finding is a regular issue carrying a **security impact**, which is how the Issues page can
be filtered to show just the security-relevant ones.

It also demonstrates the possibility to define your own custom sources, validators and sinks to detect more injection cases
(or avoid false positives)

## Usage

Run `./run.sh`

This will:
- Delete the project key **training:security** if it exists in SonarQube (to start from a scratch)
- Run `mvn clean verify sonar:sonar` to re-create the project

Project consists of a single class (`training.security.Insecure`, in `src/main/java/training/security/Insecure.java`).
Expect around 22 issues, 11 of them with a security impact: two `javasecurity:S3649` SQL
injections and one `javasecurity:S6549` path traversal at BLOCKER, plus review-style findings on
Jackson deserialization (`java:S4544`), world-writable directories (`java:S5443`), temp file
creation (`java:S5445`), a short RSA key (`java:S4426`), dynamically formatted SQL (`java:S2077`)
and cookies missing the `HttpOnly` and `secure` flags (`java:S3330`, `java:S2092`).

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
