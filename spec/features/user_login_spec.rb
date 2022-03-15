require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  
    # SETUP
    before :each do
      User.create!(
        name: 'User',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

  scenario "They see all products" do
    # ACT
    visit login_path

    # VERIFY
    fill_in'email', with:'test@test.com'
    fill_in'password', with:'password'

    click_button('Submit')

    expect(page).to have_content('Signed in as User')

    # DEBUG
    save_screenshot

  end



end