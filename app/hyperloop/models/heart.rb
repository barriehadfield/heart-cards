class Heart < ApplicationRecord
  belongs_to :created_by, class_name: :Member
  belongs_to :updated_by, class_name: :Member

  has_many :reports

  scope :active, -> () { order(id: :desc).where("id > ?", 1) }

end
