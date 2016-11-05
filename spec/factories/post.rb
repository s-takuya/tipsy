FactoryGirl.define do
  factory :post do
    body '#花 #hoge #test'
    image_file_name 'test.jpg'
    image_content_type 'image/jpeg'
    image_file_size 632132

    association :user
  end
end
