class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order :done, :priority }, dependent: :destroy

  validates :name, presence: true, length: { maximum: 48 }
  validates :user, presence: true
end
