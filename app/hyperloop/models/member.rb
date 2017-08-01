class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

 def self.current
   Hyperloop::Application.acting_user_id ? find(Hyperloop::Application.acting_user_id) : Member.new
 end

end
