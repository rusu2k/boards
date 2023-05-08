# FactoryBot.define do
#     factory :user do
#         sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
#         password { "123456" }
#         roles { [association(:role)] }

#         trait :developer do
#             role { association(:role, :developer) }
#         end

#         trait :manager do
#             role { association(:role, :manager) } # This creates a role using the :role factory with the :manager trait
#           end
          
#           trait :admin do
#             role { association(:role, :admin) } # This creates a role using the :role factory with the :admin trait
#           end
#     end
#   end
FactoryBot.define do
    factory :user do
        sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
        password { "123456" }
        #role { association(:role) }
    end
  end