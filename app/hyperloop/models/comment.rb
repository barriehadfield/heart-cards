class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :created_by, class_name: :Member
  belongs_to :report
end
