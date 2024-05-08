//Testing products on the home page

describe('Navigate to home page', () => {
	it('should visit the home page', () => {
		cy.visit('http://localhost:3000')
	})

	it("should have products on the page", () => {
		cy.get(".products article").should("be.visible");
	});

	it("should have 2 products on the page", () => {
		cy.get(".products article").should("have.length", 2);
	});
})