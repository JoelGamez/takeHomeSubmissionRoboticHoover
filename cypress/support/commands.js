Cypress.Commands.add("activateHooverSession", (roomDetails) => {
  cy.request({
    method: "POST",
    url: Cypress.env("BASE_URL"),
    body: roomDetails,
    failOnStatusCode: false,
    headers: {
      "Content-Type": "application/json",
    },
  }).as("response");
});
