require 'rails_helper'

feature "Sign In", type: :feature do
    scenario "Verifica a mensagem de Bem-Vindo" do
        visit(new_user_session_path)
        expect(page).to have_content('Bem-vindo')
    end

    scenario "Verifica link cadastro de cliente" do
        visit(new_user_session_path)
        expect(page).to have_link('Cadastre-se agora!')
    end

    scenario "Verifica botão de login" do
        visit(new_user_session_path)
        expect(page).to have_selector("input[type=submit][value=Login]")
    end
end