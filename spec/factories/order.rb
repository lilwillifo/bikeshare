factory :order do
  sequence(:total) { |n| n }
  user
  status 0
end
