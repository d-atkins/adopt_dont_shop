class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :approximate_age, :sex, :status
  belongs_to :shelter
end
