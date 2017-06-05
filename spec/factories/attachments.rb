FactoryGirl.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'img', 'test_logo.jpg'), 'image/jpg') }
  end
end
