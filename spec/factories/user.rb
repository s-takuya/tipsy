FactoryGirl.define do
  factory :user do
    uid 11111
    email 'test@test.com'
    image 'http://test.jpg'
    provider 'facebook'
  end
end
