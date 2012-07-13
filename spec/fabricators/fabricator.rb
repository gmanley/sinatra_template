Fabricator(:user) do
  email { |user| Faker::Internet.free_email }
  password 'password'
  password_confirmation { |user| user['password'] }
end
