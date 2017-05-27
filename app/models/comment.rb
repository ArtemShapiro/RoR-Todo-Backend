class Comment < ApplicationRecord
  belongs_to :task
  has_one :attachment, as: :attachable

  validates :text, presence: true
end
