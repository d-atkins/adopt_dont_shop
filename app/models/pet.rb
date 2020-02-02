class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :approximate_age, :sex, :status
  belongs_to :shelter

  def self.sort_by_status
    Pet.order(:status)
  end
end
