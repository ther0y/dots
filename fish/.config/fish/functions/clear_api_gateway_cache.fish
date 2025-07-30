function clear_api_gateway_cache
    # Load the mapping file or define inline mappings
    set -l mappings "
website-live 75h5tzgwdd live
website-dev x3jtjrke42 development
website-staging uh9w3wa7ka live-website-staging
contents-live zzxe5lifdc live
contents-dev jhwb8g5g11 development
"

    # Ensure an argument is provided
    if test (count $argv) -ne 1
        echo "Usage: clear_api_gateway_cache <key>"
        echo "Available keys:"
        echo $mappings | awk '{print $1}'
        return 1
    end

    set -l key $argv[1]

    # Find the matching mapping
    set -l found (echo $mappings | grep "^$key ")

    # Check if the key exists in the mapping
    if test -z "$found"
        echo "Error: Key '$key' not found in mappings."
        return 1
    end

    # Extract the API Gateway ID and stage from the mapping
    set -l rest_api_id (echo $found | awk '{print $2}')
    set -l stage_name (echo $found | awk '{print $3}')

    # Run the AWS CLI command
    aws apigateway flush-stage-cache --rest-api-id $rest_api_id --stage-name $stage_name
    if test $status -eq 0
        echo "Cache cleared successfully for key: $key (API Gateway ID: $rest_api_id, Stage: $stage_name)"
    else
        echo "Failed to clear cache. Check your AWS CLI configuration."
    end
end

