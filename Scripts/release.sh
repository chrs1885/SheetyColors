#!/bin/bash

# Run this script from the root directory just before releasing a new SheetyColors version or submitting a new pull request.

#============================= Linting & Formatting =============================
echo "Running SwiftFormat"
swift run swiftformat ../

echo "Running SwiftLint"
swift run swiftlint autocorrect --path ../

#================================= Documentation ================================
echo "Generating docs with SourceDocs"
swift run sourcedocs generate --output-folder ../Documentation/Reference -- -workspace ../Example/SheetyColors.xcworkspace -scheme SheetyColors