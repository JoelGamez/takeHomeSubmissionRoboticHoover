import { Given, When, Then } from "cypress-cucumber-preprocessor/steps";
import { activateHooverSessionRequest } from "../../support/hooverApiHelper";

let roomDetails;

beforeEach(() => {
  // Reset room details before each test
  roomDetails = {
    roomSize: [0, 0],
    coords: [0, 0],
    patches: [],
    instructions: "",
  };
});

Given(/^the room has dimensions (.+) by (.+)$/, (x, y) => {
  roomDetails.roomSize = [
    isNaN(x) ? x : parseInt(x),
    isNaN(y) ? y : parseInt(y),
  ];

  cy.task("log", Cypress.env("BASE_URL"));
});

Given(/^the hoover starts at position (.+), (.+)$/, (x, y) => {
  roomDetails.coords = [isNaN(x) ? x : parseInt(x), isNaN(y) ? y : parseInt(y)];
});

Given("there are dirt patches at positions:", (dataTable) => {
  roomDetails.patches = dataTable
    .hashes()
    .filter((row) => row.x.trim() !== "" && row.y.trim() !== "") // Filter out empty rows
    .map((row) => [parseInt(row.x), parseInt(row.y)]);
});

When("the movement instructions are {string}", (instructions) => {
  roomDetails.instructions = instructions;

  // Make API request
  cy.activateHooverSession(roomDetails).as("response");
});

Then("the final hoover position should be {int}, {int}", (x, y) => {
  cy.get("@response").then((response) => {
    expect(response.body.coords).to.deep.equal([x, y]);
  });
});

Then("the number of cleaned patches should be {int}", (patches) => {
  cy.get("@response").then((response) => {
    expect(response.body.patches).to.equal(patches);
  });
});

Then("an error should be raised", () => {
  cy.get("@response").then((response) => {
    expect(response.status).to.equal(400);
  });
});
