require 'rails_helper'

RSpec.describe "accounts/edit", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :bank => nil,
      :agency_number => "MyString",
      :account_number => "MyString",
      :account_type => 1
    ))
  end

  it "renders the edit account form" do
    render

    assert_select "form[action=?][method=?]", account_path(@account), "post" do

      assert_select "input[name=?]", "account[bank_id]"

      assert_select "input[name=?]", "account[agency_number]"

      assert_select "input[name=?]", "account[account_number]"

      assert_select "input[name=?]", "account[account_type]"
    end
  end
end
