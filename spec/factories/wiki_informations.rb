require 'faker'

FactoryGirl.define do
  factory :wiki, class: 'WikiInformation' do |w|
    w.association :creator, factory: :user
    w.sequence(:name) {|n| "wiki-name-#{n}"}
    w.is_private false
  end
end
