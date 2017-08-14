class Update < ApplicationRecord

  validates :body, presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: %w(happiness engagement adoption retention task_success) }

  belongs_to :member
  belongs_to :heart
end
