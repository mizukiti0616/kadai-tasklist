class Task < ApplicationRecord
  validates :status, presence: true, length: { maximum: 10 }
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
