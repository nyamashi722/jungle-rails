describe('Jungle rails app', () => {

  it("There are products on the page", () => {
    cy.visit('http://localhost:3000/')
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})