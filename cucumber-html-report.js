const report = require("multiple-cucumber-html-reporter");

report.generate({
  jsonDir: "cypress/cucumber-json", // ** Path to JSON files **
  reportPath: "./reports/cucumber-htmlreport.html", // ** Path to save the HTML report **
  metadata: {
    browser: {
      name: "chrome", // Name of the browser you used for testing
    },
    device: "Local test machine", // Can be updated based on the environment
    platform: {
      name: "mac", // OS name (can be "windows", "linux", etc.)
    },
  },
});
