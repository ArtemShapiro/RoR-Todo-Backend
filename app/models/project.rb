class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order :done, :priority }, dependent: :destroy 

  validates :name, :user, presence: true
end
