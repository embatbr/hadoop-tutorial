#!/bin/bash


PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$PROJECT_ROOT/install.sh "standalone"

echo "Run file \`examples_standalone_mode.sh\` to test Hadoop installation."
