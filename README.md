# Rate Cards & Role rates - Sample Shell Script - Mac/Linux Version #

This project uses a (Mac/Linux) shell script to query Mavenlink's API to collect the active Rate Card version at a given date and the rates for the roles attached to that Rate Card.

## Pre-Requisites ##

  1. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
     - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Ratecard-sample-shell)
     - make the shell scripts executable (run this code inside that folder only): chmod +x *.sh
     - run the setup script: ./setup.sh (follow the prompts)
  3. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Getting Rate Card details ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Ratecard-sample-shell
  3. Run the script: ./get_rate.sh
  4. Follow the instructions on the prompt
  5. Output options
      - HTML: if you run the script with the w switch, it will show the results as a HTML file in your browser. Usage:  ./get_rate.sh w
      - Console: if you run the script without any switches or with switch c the results will be shown on your console. Usage: ./get_rate.sh or ./get_rate.sh c
      - Set date: You can set the date as you run the script by adding the date in YYYY-MM-DD format after one of the switches above. You MUST provide a display switch (w or c) if you want to set the date this way. Usage: ./get_rate.sh w 2019-08-16   or ./get_rate.sh c 2019-08-16

  Disclaimer: These scripts are provided as sample code and they are NOT official Mavenlink tools, but generated as part of an exercise to investigate the use of Mavenlink's API based on specific scenarios. The developer accepts no liability for any issues that could arise from using these scripts.
