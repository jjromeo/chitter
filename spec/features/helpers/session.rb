module SessionHelpers

    def sign_in(username = "Jerome", password = 'test')
        visit '/sessions/new'
        fill_in 'username', with: username
        fill_in 'password', with: password
        click_button 'Sign in'
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