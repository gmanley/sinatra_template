require 'acceptance_helper'

feature 'Registration' do

  let(:user) { Fabricate.build(:user) }
  let(:errors) { find('.alert-block ul') }

  scenario "successfully registering a new account with valid data" do
    visit('/user/new')

    within('#register') do
      fill_in('email', :with => user.email)
      fill_in('password', :with => user.password)
      fill_in('password_confirmation', :with => user.password)
      click_button('Sign Up')
    end

    find('#user_dropdown .dropdown-toggle').should have_content(user.email)
  end

  scenario "display errors when attempting to register a new account with invalid information" do
    visit('/user/new')

    within('#register') do
      fill_in('email', :with => '')
      fill_in('password', :with => user.password)
      fill_in('password_confirmation', :with => 'different_password')
      click_button('Sign Up')
    end

    errors.should have_content("Password doesn't match confirmation")
    errors.should have_content("Email can't be blank")
    errors.should have_content('Email is invalid')
  end
end
