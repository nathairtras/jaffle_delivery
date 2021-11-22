#!/usr/bin/env bash
set -e
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Creating DBT Profile directory if it does not exist"
echo "  $HOME/.dbt"
mkdir -p $HOME/.dbt
echo "Creating local script directory:"
echo "  $HOME/.local/bin"
mkdir -p $HOME/.local/bin
echo "Installing DBT wrapper script"
cp $SCRIPT_DIR/dbt $HOME/.local/bin/dbt
echo "Setting script to executable"
chmod 700 $HOME/.local/bin/dbt
echo "Add this line to the end of $HOME/.profile or $HOME/.zshrc"
echo ""
echo 'export PATH=$HOME/.local/bin:$PATH'
echo ""
echo "This will ensure that your script directory is executable."
