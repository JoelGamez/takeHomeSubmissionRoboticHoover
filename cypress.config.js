const { defineConfig } = require("cypress");
const cucumber = require("cypress-cucumber-preprocessor").default;
require("dotenv").config();

module.exports = defineConfig({
  e2e: {
    specPattern: "cypress/api/features/*.feature",
    setupNodeEvents(on, config) {
      on("file:preprocessor", cucumber());

      // Load environment variables from .env file
      config.env.BASE_URL = process.env.BASE_URL;

      // Register the 'log' task
      on("task", {
        log(message) {
          console.log(message);
          return null;
        },
      });

      return config;
    },
    stepDefinitions: "cypress/api/steps/*.js",
  },
});
