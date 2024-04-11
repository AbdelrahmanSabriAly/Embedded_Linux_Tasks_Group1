# Log Analysis Script

This Bash script allows you to analyze and filter log files based on predefined log types and track specific system events. It provides a menu-driven interface for interacting with log data and generating a comprehensive analysis report.

## Features

- **Log Analysis**:
  - Parses log files based on configured log types (`info`, `error`, `warning`, `debug`).
  - Filters and displays logs by selected log types.
  - Sorts log entries by date and time.

- **Event Tracking**:
  - Tracks specific system events within log files (e.g., "System Startup Sequence Initiated", "System health check OK").
  - Checks the presence of defined events in the log file and reports the status.

- **Report Generation**:
  - Generates a detailed report summarizing log analysis findings.
  - Includes counts of each log type (`info`, `error`, `warning`, `debug`).
  - Reports the status of tracked system events.

## Usage

1. **Setup**:
   - Ensure the `log_config.conf` file is correctly configured with log types and keywords.

2. **Run the Script**:
   - Make the script executable:
     ```bash
     chmod +x log_analysis_script.sh
     ```
   - Execute the script with a log file as an argument:
     ```bash
     ./log_analysis_script.sh path/to/your_log_file.log
     ```

3. **Interact with the Menu**:
   - Choose options from the interactive menu:
     - Filter logs by type (`info`, `error`, `warning`, `debug`).
     - Generate a comprehensive report summarizing log analysis.
     - Quit the script.

## Requirements

- Bash (Bourne Again SHell)
- `sort` (standard Unix utility for sorting text files)
- `grep` (command-line utility for searching text patterns)
- `sed` (stream editor for filtering and transforming text)

## Configuration

- **log_config.conf**:
  - Configure log types and associated keywords in this file.
  - Example format:
    ```plaintext
    [info]
    keywords = login success, session started

    [error]
    keywords = error, exception, failed
    ```

## File Structure

- `log_analysis_script.sh`: Main Bash script for log analysis.
- `log_config.conf`: Configuration file defining log types and keywords.
- `output_logs.log`: Output file with log entries prefixed by log types.
- `log_report.txt`: Generated report summarizing log analysis findings.

## Example

```bash
./log_analysis_script.sh example_logs.log
