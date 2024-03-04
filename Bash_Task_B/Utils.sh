#!/bin/bash

# Log file path
declare LOG_FILE="process_monitor.log"
declare PID
declare total_processes
declare memory_usage
declare cpu_load
declare PROCESS_NAME

#__________________________________ Functions__________________________________

# Function to read configuration from file
function READ_CONFIG_FILE() {
    if [[ -f process_monitor.conf ]]; then
        source process_monitor.conf
    else
        LOG_MESSAGE "Configuration file not found or invalid. Using default values."
    fi
}

# Function to read configuration from file
function READ_LOG_FILE() {
    if [[ -f process_monitor.log ]]; then
        source process_monitor.log
    else
        echo "Log file not found or invalid. Using default values."
    fi
}

function KILL_PROCESS() {
    read -r -p "Enter the process ID to kill: " PID
    if [[ -z $PID ]]; then
        LOG_MESSAGE "No process ID provided. Exiting."
    else
        kill "$PID"
        if [[ $? -eq 0 ]]; then
            LOG_MESSAGE "Process with PID $PID killed successfully."
        else
            LOG_MESSAGE "Failed to kill process with PID $PID."
        fi
    fi
}

function PRINT_PROCESS_STAT() {
    # Display total number of processes
    total_processes=$(ps -e | wc -l)

    # Display memory usage
    memory_usage=$(free -m | grep Mem | awk '{print $3 " MB used out of " $2 " MB"}')

    # Display CPU load
    cpu_load=$(uptime)

    # Display the collected statistics
    echo "Total Number of Processes: $total_processes"
    echo "Memory Usage: $memory_usage"
    echo "CPU Load: $cpu_load"
}

function REAL_TIME_MONITORING() {
    trap 'return' SIGINT # Catch Ctrl+C and return from the function
    while true; do
        clear # Clear the screen before displaying updated information
        echo "Real-time Monitoring - Press Ctrl+C to exit"

        # Display latest process information
        ps aux

        # Sleep for 2 seconds before updating the display again
        sleep "$UPDATE_INTERVAL"
    done
}

function SEARCH_FOR_PROCESS() {

    read -r -p "Enter search criteria (process name, user, etc.): " PROCESS_NAME

    # Search and filter processes based on the user input
    pgrep -fl "$PROCESS_NAME"
}

function CHECK_CPU_USAGE() {
    local pid=$1
    local cpu_usage
    cpu_usage=$(ps -p "$pid" -o %cpu | tail -n 1)

    if [ -n "$cpu_usage" ] && [ -n "$CPU_THRESHOLD" ]; then
        if [[ "$cpu_usage" == "%CPU" ]]; then
            LOG_MESSAGE "Warning: CPU usage not available for process $pid"
        else
            if [ "$(echo "$cpu_usage > $CPU_THRESHOLD" | bc)" -eq 1 ]; then
                LOG_MESSAGE "Process $pid has exceeded CPU threshold ($CPU_THRESHOLD%): CPU usage is $cpu_usage%"
            fi
        fi
    else
        LOG_MESSAGE "Error: CPU thresholds not properly set or CPU usage not available for process $pid."
    fi
}

function CHECK_MEMORY_USAGE() {
    local pid=$1
    local memory_usage
    memory_usage=$(ps -p "$pid" -o %mem | tail -n 1)

    if [ -n "$memory_usage" ] && [ -n "$MEMORY_THRESHOLD" ]; then
        if [[ "$memory_usage" == "%MEM" ]]; then
            LOG_MESSAGE "Warning: Memory usage not available for process $pid"
        else
            if [ "$(echo "$memory_usage > $MEMORY_THRESHOLD" | bc)" -eq 1 ]; then
                LOG_MESSAGE "Process $pid has exceeded memory threshold ($MEMORY_THRESHOLD%): Memory usage is $memory_usage%"
            fi
        fi
    else
        LOG_MESSAGE "Error: Memory thresholds not properly set or memory usage not available for process $pid."
    fi
}

# Main function to monitor processes
function SEARCH_FOR_ALERTS() {
    while true; do
        # Get list of all process IDs
        pids=$(ps -eo pid | tail -n +2)

        # Iterate through each process and check CPU and memory usage
        for pid in $pids; do
            CHECK_CPU_USAGE "$pid"
            CHECK_MEMORY_USAGE "$pid"
        done

        # Sleep for 5 seconds before checking again
        sleep "$UPDATE_INTERVAL"
    done
}

# Function to log messages
function LOG_MESSAGE() {
    local message=$1
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >>"$LOG_FILE"
}
