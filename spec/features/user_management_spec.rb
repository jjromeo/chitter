require 'spec_helper'
require_relative 'helpers/session'

feature "User signs in" do 
    include SessionHelpers

    before(:each) do 
        User.create(username: "Jerome",
                    email: "Jerome@test.com",
                    password: "test",
                    password_confirmation: "test")
    end

    scenario "with correct credentials" do 
        visit '/'
        expect(page).not_to have_content("Welcome, Jerome")
        sign_in('Jerome', 'test')
        expect(page).to have_content("Welcome, Jerome")
    end

    scenario "with incorrect credentials" do 
        visit '/'
        expect(page).not_to have_content("Welcome, Jerome")
        sign_in('Jerome', 'wrong')
        expect(page).not_to have_content("Welcome, Jerome")
    end
end

feature "User signs out" do 
    include SessionHelpers
    before(:each) do
        User.create(username:"Jerome",
                    email:"Jerome@test.com",
                    password:"test",
                    password_confirmation: "test")
    end

    scenario "logging out" do 
        sign_in
        click_button 'Sign out'
        expect(page).to have_content "Goodbye!"
        expect(page).not_to have_content "Welcome, Jerome"
    end

end

















