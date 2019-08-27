# Rate Cards & Role rates #

This project uses a shell script to query Mavenlink's API to collect the active Rate Card version at a given date and the rates for the roles attached to that Rate Card.

## Pre-Requisites ##

  1. Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - Navigate to the folder where you saved the scripts (E.G: cd Documents/web_files/ratecard_api)
     - make the shell scripts executable
       . chmod +x setup.sh
       . chmod +x get_rate.sh
     - run the setup script: ./setup.sh
       . follow the prompts
  2. Update the token.json file with your Mavenlink API token

## Getting Rate Card details ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd Documents/web_files/ratecard_api
  3. Run the script: ./get_rate.sh
  4. Follow the instructions on the prompt
  5. Output options
      - HTML: if you run the script with the w switch, it will show the results as a HTML file in your browser. Usage:  ./get_rate.sh w
      - Console: if you run the script without any switches or with switch c the results will be shown on your console. Usage: ./get_rate.sh or ./get_rate.sh c
      - Set date: You can set the date as you run the script by adding the date in YYYY-MM-DD format after one of the switches above. You MUST provide a display switch (w or c) if you want to set the date this way. Usage: ./get_rate.sh w 2019-08-16   or ./get_rate.sh c 2019-08-16
