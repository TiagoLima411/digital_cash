require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :bank => nil,
      :agency_number => "Agency Number",
      :account_number => "Account Number",
      :account_type => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Agency Number/)
    expect(rendered).to match(/Account Number/)
    expect(rendered).to match(/2/)
  end
end
