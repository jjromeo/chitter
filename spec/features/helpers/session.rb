module SessionHelpers

    def sign_in(username = "Jerome", password = 'test')
        visit '/sessions/new'
        fill_in 'username', with: username
        fill_in 'password', with: password
        click_button 'Sign in'
    end

end