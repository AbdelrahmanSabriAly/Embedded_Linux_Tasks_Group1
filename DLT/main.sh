#!/bin/bash

# ____________________________________________ Global Variables ______________________________________________ #

# Configuration file
declare CONFIG_FILE="log_config.conf"
declare LOG_FILE="$1"
declare OUTPUT_FILE="output_logs.log"
declare REPORT_FILE="log_report.txt"
declare -a EVENTS
declare log_types=("info" "error" "warning" "debug")

# ___________________________________________ Functions ______________________________________________ #

# Function to sort log file by date/time
function sort_logs_by_date() {
    local input_file="$1"

    # Sort the log file by date/time
    sort -o "$input_file.sorted" -k2M -k3n -k4 "$input_file"
    mv "$input_file.sorted" "$input_file"
}

# Function to create output log file with log types prefixed
function create_output_log() {

    # Create output log file with log types prefixed
    >"$OUTPUT_FILE" # Clear or create the output file

    for log_type in "${log_types[@]}"; do

        #Get the keywords from the config file
        local keywords
        keywords=$(grep "\[$log_type\]" "$CONFIG_FILE" | sed 's/keywords\s*=\s*//')

        # Convert keywords to grep pattern
        local grep_pattern
        grep_pattern=$(echo "$keywords" | sed 's/, /\\|/g')

        # Loop through logs and append to output file with log type prefix
        grep -iE "\\b($grep_pattern)\\b" "$LOG_FILE" | while IFS= read -r log_entry; do
            echo "[$log_type] $log_entry" >>"$OUTPUT_FILE"
        done
    done

    sort_logs_by_date "$OUTPUT_FILE"
    echo "Output log file created: $OUTPUT_FILE"
}

# Function to print the summary of logs of a certain type
function print_summary(){
    print_line

    local log_type="$1"
    # Count logs for the selected type
    local log_count
    log_count=$(grep -cE "^\[$log_type\]" "$OUTPUT_FILE")

    # Print summary
    echo "Summary for $log_type logs:"
    echo "Total count: $log_count"

    print_line
}

# Function to filter and display logs by selected log type
function filter_logs_by_type() {
    local log_type="$1"

    # Print logs of the selected type
    echo -e "\nLogs of type $log_type:"
    grep -iE "^\[$log_type\]" "$OUTPUT_FILE"
    print_line

}

function read_events_from_config_file(){
    echo "Reading events from config file..."
    while IFS='=' read -r key value; do
        if [[ -n "$value" ]]; then
            EVENTS+=("$value")
        fi
    done < <(grep '^\[events\]' -A 999 "$CONFIG_FILE" | grep -v '^\[events\]' | sed '/^\s*$/d')
    
}


# Function to track specific system events
function track_system_events() {

    echo "Tracking system events..."

    for event in "${EVENTS[@]}"; do
        if grep -qi "$event" "$LOG_FILE"; then
            echo "[Event] $event: Found in the logs."
        else
            echo "[Event] $event: Not found in the logs."
        fi
    done

    print_line
}

# Function to generate a report summarizing log analysis
function generate_report() {
    # Write log analysis summary to report file
    echo "Log Analysis Report" >"$REPORT_FILE"
    echo "===================" >>"$REPORT_FILE"
    echo -e "\n" >>"$REPORT_FILE"

    # Generate log type summaries
    local log_types=("info" "error" "warning" "debug")

    for log_type in "${log_types[@]}"; do
        local log_count=$(grep -cE "^\[$log_type\]" "$OUTPUT_FILE")
        echo "Summary for $log_type logs:" >>"$REPORT_FILE"
        echo "Total count: $log_count" >>"$REPORT_FILE"
        echo -e "\n" >>"$REPORT_FILE"

    done

    # Generate system events status
    echo "System Events Status:" >>"$REPORT_FILE"
    track_system_events >>"$REPORT_FILE"

    echo "Report generated: $REPORT_FILE"
}

# Helper function to print a line separator
function print_line() {
    echo "==================================================================================================="
}

# __________________________________________ Main function ______________________________________________ #

function main() {

    # Main script
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Error: Configuration file '$CONFIG_FILE' not found."
        exit 1
    fi
    # read the trackable events from the config file
    read_events_from_config_file


    # Create output log file with log types prefixed
    create_output_log

    # Display menu and prompt user to select log type or generate report
    PS3="Select an option (enter the number): "
    options=("info" "error" "warning" "debug" "Generate Report" "Quit")

    select opt in "${options[@]}"; do
        case "$opt" in
        "info")
            
            print_summary "info"
            filter_logs_by_type "info"
            ;;
        "error")
            print_summary "error"
            filter_logs_by_type "error"
            ;;
        "warning")
            print_summary "warning"
            filter_logs_by_type "warning"
            ;;
        "debug")
            print_summary "debug"
            filter_logs_by_type "debug"
            ;;
        "Generate Report")
            generate_report
            cat $REPORT_FILE
            ;;
        "Quit")
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please select again."
            ;;
        esac
    done

}

main
