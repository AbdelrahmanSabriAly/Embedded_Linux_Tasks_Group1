# DLT Log Analyzer

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
   - Ensure to update the `log_config.conf` file with the required keywords and trackable events
   
![image](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/5454f4a4-924c-44e9-97de-7f0aade586eb)


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
./log_analysis_script.sh syslog
```

## Output:
![Screenshot from 2024-04-11 22-43-42](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/5ef836a5-92d6-44db-b385-0d6d6b2e5bad)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-44-22](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/a229a8c2-73ee-4dc0-906b-c8afee661756)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-44-58](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/7c8bef08-c7e0-4473-a094-d2d5efb4ae6c)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-45-22](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/d9f7d253-d5e5-4fe0-9b03-9fe99d197d9e)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-45-40](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/3a21d91f-9962-4061-add8-0364d0268b01)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-52-21](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/57e7933b-1b0f-4805-8dc7-1e4461a8e058)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------

![Screenshot from 2024-04-11 22-52-59](https://github.com/AbdelrahmanSabriAly/Embedded_Linux_Tasks_Group1/assets/137514155/2e776b5c-0755-4728-ae65-34c4c9536c93)
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------










