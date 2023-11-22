describe('Jungle rails app', () => {
  it("There are products on the page", () => {
    cy.visit('http://localhost:3000/')
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Navigates to a product details page when a product is clicked", () => {
    cy.get(".products article:first").click()
  });

  it("There is 1 product on the page", () => {
    cy.get(".product-detail").should("have.length", 1);
  });

})