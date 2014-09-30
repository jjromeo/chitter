require 'spec_helper'
require_relative 'helpers/session'
feature "User signs up" do 

    scenario "when being logged out" do 
        expect{ sign_up }.to change(User, :count).by(1)
        expect(page).to have_content("Welcome, Jerome")
        expect(User.first.email).to eq("jerome@test.com")
        expect(User.first.username).to eq("Jerome")
    end

    scenario "with a password that doesn't match" do 
        expect{ sign_up('a@a.com', 'pass', 'wrong')}.to change(User, :count).by(0)
        expect(current_path).to eq('/users')
        expect(page).to have_content("Password does not match the confirmation")
    end

    scenario "with a username that is already registered" do 
        expect{ sign_up }.to change(User, :count).by(1)
        expect{ sign_up }.to change(User, :count).by(0)
        expect(page).to have_content("This username is already taken")
    end

    def sign_up(username = "Jerome", email = "jerome@test.com",
                password = "test",
                password_confirmation = "test")
        visit '/users/new'
        expect(page.status_code).to eq(200)
        fill_in :username, with: username
        fill_in :email, with: email
        fill_in :password, with: password
        fill_in :password_confirmation, with: password_confirmation
        click_button "Sign up"
    end
end