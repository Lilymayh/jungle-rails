describe('Navigate to Product Detail Page', () => {
  beforeEach(() => {
    cy.visit('localhost://3000');
  });

  it('should navigate from home page to product detail page by clicking on a product', () => {
    cy.get('article').first().find('a').click();

    cy.url().should('include', '/products/2');
  });
});