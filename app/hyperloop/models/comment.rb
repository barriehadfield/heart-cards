class Comment < ApplicationRecord
  belongs_to :created_by, class_name: :Member
  # belongs_to :report
end
