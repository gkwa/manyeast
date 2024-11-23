#!/bin/bash

print_usage() {
    echo "Usage: source setup-aws-vault.sh"
    echo "Note: This script must be sourced, not executed directly"
    echo "      because it needs to modify your current shell's environment"
}

# Check if the script is being sourced
if [[ ${BASH_SOURCE[0]} == "${0}" ]]; then
    echo "Error: This script must be sourced, not executed directly"
    print_usage
    exit 1
fi

# Prompt for the passphrase securely (hidden input)
echo -n "Enter AWS Vault file passphrase: "
read -rs AWS_VAULT_FILE_PASSPHRASE
echo # Add newline after hidden input

# Export the variable
export AWS_VAULT_FILE_PASSPHRASE

# Confirm to user
echo "AWS Vault passphrase has been set for this shell session"
echo "You can now use aws-vault commands without being prompted for the passphrase"
