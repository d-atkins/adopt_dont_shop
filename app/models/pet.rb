class Pet < ApplicationRecord
  validates_presence_of :image_path, :name, :description, :approximate_age, :sex
  belongs_to :shelter
end
