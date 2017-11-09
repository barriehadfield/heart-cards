class Member < ApplicationRecord

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :created_hearts, foreign_key: :created_by_id, class_name: 'Heart'
  has_many :updated_hearts, foreign_key: :updated_by_id, class_name: 'Heart'

  has_many :reports

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable unless RUBY_ENGINE == 'opal'

 def self.current
   Hyperloop::Application.acting_user_id ? find(Hyperloop::Application.acting_user_id) : Member.new
 end

 def full_name
   "#{first_name} #{last_name}"
 end

end
