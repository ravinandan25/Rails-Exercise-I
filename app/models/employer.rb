class Employer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true, length: { is: 10 }
  validates :gender, presence: true
  validates :location, presence: true
end
