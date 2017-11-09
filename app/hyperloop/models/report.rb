class Report < ApplicationRecord

  validates :body, presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: %w(happiness engagement adoption retention task_success) }

  belongs_to :member
  belongs_to :heart

  has_many :comments

  scope :for_heart_category, ->(heart_id, category) { where(heart_id: heart_id).where(category: category) }

end
