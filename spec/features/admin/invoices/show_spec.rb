require "rails_helper"

RSpec.describe "Admin Invoice Show Page", type: :feature do
  describe "when I visit '/admin/invoices/:invoice_id'" do
    it "I the invoice ic, invoice status, invoice created_at in correct format, and customer first and last name" do
      customer_1 = create(:customer)

      invoice_1 = create(:invoice, created_at: "2012-03-25 09:54:09 UTC", customer: customer_1)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Invoice #{invoice_1.id}")
      expect(page).to have_content("Status: #{invoice_1.status}")
      expect(page).to have_content("Created: Sunday, March 25, 2012")
      expect(page).to have_content("Customer: #{customer_1.first_name} #{customer_1.last_name}")
    end

    it "I see the total revenue that will be generated from this invoice" do
      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1)

      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant: merchant_1)

      invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 24642, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, quantity: 8, unit_price: 12463, invoice: invoice_1, item: item_1)
      invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 23567, invoice: invoice_1, item: item_1)

      visit "/admin/invoices/#{invoice_1.id}"

      expect(page).to have_content("Total Revenue: $2,700.48")
    end
  end
end