require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :bank => nil,
        :agency_number => "Agency Number",
        :account_number => "Account Number",
        :account_type => 2
      ),
      Account.create!(
        :bank => nil,
        :agency_number => "Agency Number",
        :account_number => "Account Number",
        :account_type => 2
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Agency Number".to_s, :count => 2
    assert_select "tr>td", :text => "Account Number".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
