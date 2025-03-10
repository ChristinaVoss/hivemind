module AuthenticationHelpers
  def sign_in(user)
    visit new_session_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
