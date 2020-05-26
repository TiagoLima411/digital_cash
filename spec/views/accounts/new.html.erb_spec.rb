require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      :bank => nil,
      :agency_number => "MyString",
      :account_number => "MyString",
      :account_type => 1
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input[name=?]", "account[bank_id]"

      assert_select "input[name=?]", "account[agency_number]"

      assert_select "input[name=?]", "account[account_number]"

      assert_select "input[name=?]", "account[account_type]"
    end
  end
end
