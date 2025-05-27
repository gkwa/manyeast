#!/bin/bash

# obsidian-curl.sh

# Obsidian REST API - Simple curl interface
API_KEY="20542e4b219842e7cbeaa24dd964e795b81e8c391c5597aa86478affa2755a15"
BASE_URL="https://127.0.0.1:27124"

usage() {
    echo "Usage: $0 COMMAND [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  create FILENAME 'CONTENT'  - Create a new note"
    echo "  read FILENAME              - Read a note"
    echo "  update FILENAME 'CONTENT'  - Update a note"  
    echo "  list                       - List all files"
    echo ""
    echo "Examples:"
    echo "  $0 create 'meeting-notes.md' '# Meeting Notes\n\nDiscussed project timeline'"
    echo "  $0 read 'meeting-notes.md'"
    echo "  $0 list"
}

case "${1:-help}" in
    "create")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: $0 create FILENAME 'CONTENT'"
            exit 1
        fi
        
        echo "Creating note: $2"
        RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
            -H "Authorization: Bearer $API_KEY" \
            -H "Content-Type: text/plain" \
            -k \
            -d "$3" \
            "$BASE_URL/vault/$2")
        
        HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
        if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "201" ] || [ "$HTTP_CODE" = "204" ]; then
            echo "✓ Note created successfully!"
        else
            echo "✗ Failed to create note (HTTP $HTTP_CODE)"
        fi
        ;;
        
    "read")
        if [ -z "$2" ]; then
            echo "Usage: $0 read FILENAME"
            exit 1
        fi
        
        curl -s \
            -H "Authorization: Bearer $API_KEY" \
            -k \
            "$BASE_URL/vault/$2"
        ;;
        
    "update")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: $0 update FILENAME 'CONTENT'"
            exit 1
        fi
        
        echo "Updating note: $2"
        RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT \
            -H "Authorization: Bearer $API_KEY" \
            -H "Content-Type: text/plain" \
            -k \
            -d "$3" \
            "$BASE_URL/vault/$2")
        
        HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
        if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "204" ]; then
            echo "✓ Note updated successfully!"
        else
            echo "✗ Failed to update note (HTTP $HTTP_CODE)"
        fi
        ;;
        
    "list")
        echo "Vault contents:"
        curl -s \
            -H "Authorization: Bearer $API_KEY" \
            -k \
            "$BASE_URL/vault/" | jq -r '.files[]' 2>/dev/null || echo "Install jq for better formatting"
        ;;
        
    "help"|*)
        usage
        ;;
esac