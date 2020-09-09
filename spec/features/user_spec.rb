require 'rails_helper'
#require 'rspec/rails'

RSpec.feature "Register User", type: :feature do

  scenario 'Verifica Formulário de Cadastro' do
    visit(account_register_path)
    
    #print page.html
    #save_and_open_page

    expect(page).to have_content('Crie seu Acesso')
    expect(page).to have_selector("input[type=text][name='member[user_attributes][username]']")
    expect(page).to have_selector("input[name='member[user_attributes][password]']")
    expect(page).to have_selector("input[name='member[user_attributes][password_confirmation]']")
    expect(page).to have_selector("input[name='member[name]']")
    expect(page).to have_selector("input[type=email][name='member[email]']")
    expect(page).to have_selector("input[type=text][name='member[phone]']")
    expect(page).to have_selector("input[type=text][name='member[birthday]']")
    expect(page).to have_selector("select[name='member[gender]']")
    expect(page).to have_selector("input[name='member[cpf]']")
    expect(page).to have_selector("input[name='member[mother_name]']")
    expect(page).to have_selector("input[name='member[rg]']")
    expect(page).to have_selector("input[name='member[zipcode]']")
    expect(page).to have_selector("input[name='member[address]']")
    expect(page).to have_selector("input[name='member[address_number]']")
    expect(page).to have_selector("input[name='member[district]']")
    expect(page).to have_selector("input[name='member[complement]']")

    expect(page).to have_selector("input[type=submit][value='Criar Conta']")
  end

  scenario "Verfica Cadastro de Usuário" do
    visit(account_register_path)
    
    password = Faker::Internet.password

    fill_in('member[user_attributes][username]', with: Faker::Internet.username.gsub(/[^0-9A-Za-z]/, ''))
    fill_in('member[user_attributes][password]', with: password)
    fill_in('member[user_attributes][password_confirmation]', with: password)
    fill_in('member[name]', with: Faker::Name.name)
    fill_in('member[email]', with: Faker::Internet.email)
    fill_in('member[phone]', with: Faker::PhoneNumber.cell_phone)
    fill_in('member[birthday]', with: Faker::Date.birthday)
    find('#member_gender').find(:xpath, 'option[2]').select_option
    fill_in('member[cpf]', with: Faker::CPF.pretty)
    fill_in('member[mother_name]', with: Faker::Name.feminine_name)
    fill_in('member[rg]', with: Faker::Number.number(digits = 10))
    fill_in('member[zipcode]', with: Faker::Address.zip_code)
    fill_in('member[address]', with: Faker::Address.full_address)
    fill_in('member[address_number]', with: Faker::Address.building_number)
    fill_in('member[district]', with: Faker::Address.street_address)
    fill_in('member[complement]', with: '')

    click_on('Criar Conta')
    expect(page).to have_content('Bem-vindo')
  end

  scenario "Verifica Erro no cadastro" do
    visit(account_register_path)
    click_on('Criar Conta')
    expect(page).to have_content('Username não pode ficar em branco')
  end

end