Fabricator(:user) do
  email { |user| Faker::Internet.free_email }
  password "password"
  password_confirmation { |user| user.password }
  after_build {|user| user.send(:prepare_password) }
end
