require 'spec_helper'

feature "User signs up" do 


    scenario "when being logged out" do 
        expect{ sign_up }.to change(User, :count).by(1)
        expect(page).to have_content("Welcome, Jerome")
        expect(User.first.email).to eq("jerome@example.com")
        expect(User.first.username).to eq("Jerome")
    end

    def sign_up(username = "Jerome", email = "jerome@example.com",
                password = "potatoes!")
        visit '/users/new'
        expect(page.status_code).to eq(200)
        fill_in :username, with: username
        fill_in :email, with: email
        fill_in :password, with: password
        click_button "Sign up"
    end
end