# Robotic Hoover Navigation API Test Automation Repo

## Description

This repository is focused on testing the API service that simulates a robotic hoover navigating a room. The service takes inputs such as room size, initial hoover position, dirt patch locations, and movement instructions, then outputs the final coordinates of the hoover and the number of dirt patches cleaned.

The goal of the tests is to ensure the API service functions correctly under various scenarios and edge cases, such as invalid inputs, boundary conditions, and normal operations.

## Features

- Automated tests for API endpoints.
- Validation of room size, hoover movement, and patch cleaning logic.
- Edge case handling for invalid inputs and boundary conditions.
- Reporting on test results for API functionality.

## Prerequisites

- Node.js v.13+
- Docker v.18+ installed and running (for the hoover service)
  - Review the README attached within the hoover service repo in order to build and run with docker

## Features

- Automated tests for API endpoints.
- Validation of room size, hoover movement, and patch cleaning logic.
- Edge case handling for invalid inputs and boundary conditions.
- Reporting on test results for API functionality.

## Installation

1. Clone the repository:

   ```bash
   git clone <git@github.com:JoelGamez/takeHomeSubmissionRoboticHoover.git>
   ```

2. Navigate into the root project
   - cd takeHomeSubmissionRoboticHoover
   - npm install

## ENV Config

1. Create a .env file in the root of your project and add the necessary environment variables.
   - Set the base url to your hoover docker service. Example below:
     - BASE_URL={http://localhost:8080/v1/cleaning-sessions}

## Running Tests

1. Given this test suite is intended just for APIs, you will most likely want to run the automation headlessly
   - `npm run cypress:run` to run headless
   - `npm run cypress:open` to run utilizing the Cypress GUI

## Cucumber Report Generator

1. Run `node cucumber-html-report.js` to generate a sleek report that you can open in your browser. The logs will output a link such as:

   ```
           Multiple Cucumber HTML report generated in:
       /{yourFilePath}/takeHomeSubmission/reports/cucumber-htmlreport.html/index.html
   ```

## Project Structure Overview

    •	cypress/ - Contains the Cypress tests for the API
            - cypress/api - Contains steps & feature files used by Gherkin configurations
            - cypress/support - Contains custom command and api integration files
    •	reports/ - Stores generated test reports
    •	package.json - Includes project metadata and dependencies
    •	.env - Contains environment variables for the project
    •	cypress.config.js - Configuration for the Cypress framework

## Test Scenario Overview

    - A PDF file with detailed overview and a review of the current findings can be found within the root directory
        - takeHomeSubmissionRoboticHoover/TestCoverageOverviewAndAnalysis

## API Input

The service input will be received in a json payload with the format described here.

Example:

```javascript
{
  "roomSize" : [5, 5],
  "coords" : [1, 2],
  "patches" : [
    [1, 0],
    [2, 2],
    [2, 3]
  ],
  "instructions" : "NNESEESWNWW"
}
```

- Cypress uses its native .request() command to make API calls. This allows you to easily test API endpoints by sending HTTP requests and validating the response. For example, to test this service, you can use:

```
cy.request({
  method: 'POST',
  url: '{base_url}/v1/cleaning-sessions',
  body: {
    "roomSize": [5, 5],
    "coords": [1, 2],
    "patches": [[1, 0], [2, 2], [2, 3]],
    "instructions": "NNESEESWNWW"
  }
})
```
