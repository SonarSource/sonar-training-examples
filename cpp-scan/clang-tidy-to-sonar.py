#!/usr/local/bin/python3
'''

clang-tidy to SonarQube generic issue report converter demo

Usage: clang-tidy -checks='*' -header-filter="^include" -p . src/*.cc | ./clang-tidy-to-sonar.py > generic-issue-report.json

Or in 2 steps:
clang-tidy -checks='*' -header-filter="^include" -p . src/*.cc > clang-tidy-report.txt
./clang-tidy-to-sonar.py < clang-tidy-report.txt > generic-issue-report.json
'''

import sys
import re
import json

# Clang-tidy issue line format
# <filename>:<line>:<column>: [warning|note]: <message> [<rule>]
# Example: /Users/Olivier/dev/sonarsource/sonar-training-examples/cpp-scan/src/BiggestUnInt.cc:33:5: warning: 'bitsout' must resolve to a function declared within the '__llvm_libc' namespace [llvmlibc-callee-namespace]
p = re.compile(r'''
([^:]+):               # Filename
(\d+):                 # Line nbr
(\d+):\s*              # Col nbr
warning:\s*([^\[]+)\s* # Message  (The prefix can be also note, but we'll ignore those lines)
\[([^\]]+)\]           # Rule
''', re.VERBOSE)

issues = []
for line in sys.stdin:
    m = p.search(line)
    if not m:
        continue   # Skip non matching lines
    location = {
        'message': m.group(4),
        'filePath': m.group(1),
        'textRange': {
            'startLine': m.group(2),
            'endLine': m.group(2)
        }
    }
    col = m.group(3)
    issues.append({
        'engineId': 'clang-tidy',
        'ruleId': m.group(5),
        'primaryLocation': location,
        'severity': "MAJOR",
        "type":"CODE_SMELL",
        "effortMinutes": 5,
    })

json.dump({'issues': issues}, sys.stdout, indent=3)
