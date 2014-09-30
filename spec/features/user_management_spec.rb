require 'spec_helper'

feature "User signs up" do 


    scenario "when being logged out" do 
        expect{ sign_up }.to change(User, :count).by(1)
        expect(page).to have_content("Welcome, Jerome")
        expect(User.first.email).to eq("jerome@example.com")
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

    def sign_up(username = "Jerome", email = "jerome@example.com",
                password = "potatoes!",
                password_confirmation = "potatoes!")
        visit '/users/new'
        expect(page.status_code).to eq(200)
        fill_in :username, with: username
        fill_in :email, with: email
        fill_in :password, with: password
        fill_in :password_confirmation, with: password_confirmation
        click_button "Sign up"
    end
end

feature "User signs in" do 

    before(:each) do 
        User.create(username: "tester",
                    email: "tester@test.com",
                    password: "test",
                    password_confirmation: "test")
    end

    scenario "with correct credentials" do 
        visit '/'
        expect(page).not_to have_content("Welcome, tester")
        sign_in('tester', 'test')
        expect(page).to have_content("Welcome, tester")
    end

    scenario "with incorrect credentials" do 
        visit '/'
        expect(page).not_to have_content("Welcome, tester")
        sign_in('tester', 'wrong')
        expect(page).not_to have_content("Welcome, tester")
    end

    def sign_in(username, password)
        visit '/sessions/new'
        fill_in 'username', with: username
        fill_in 'password', with: password
        click_button 'Sign in'
    end
end