// Added this API functionality into Cypress custom commands for modularity and easier reuse in tests.
// However, I prefer keeping separate API helper files as well, in case we need to reuse the logic outside of Cypress.

export const activateHooverSessionRequest = (roomDetails) => {
  return cy
    .request({
      method: "POST",
      url: Cypress.env("BASE_URL"), // API endpoint
      body: roomDetails,
      failOnStatusCode: false,
      headers: {
        "Content-Type": "application/json",
      },
    })
    .then((response) => {
      console.log("API Response:", response);
      return response;
    });
};
