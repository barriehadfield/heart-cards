class Member < ApplicationRecord

  has_many :created_hearts, foreign_key: :created_by_id
  has_many :updated_hearts, foreign_key: :updated_by_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

 def self.current
   Hyperloop::Application.acting_user_id ? find(Hyperloop::Application.acting_user_id) : Member.new
 end

end
