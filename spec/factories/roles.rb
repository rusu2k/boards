# FactoryBot.define do
#     factory :role do
#         trait :developer do
#             name { 'developer' }
#             id { 1 }
#         end
  
#       trait :manager do
#         name { 'manager' }
#         id { 2 }
#       end
  
#       trait :admin do
#         name { 'admin' }
#         id { 3 }
#       end
  
#       factory :developer_role, traits: [:developer]
#       factory :manager_role, traits: [:manager]
#       factory :admin_role, traits: [:admin]
#     end
#   end