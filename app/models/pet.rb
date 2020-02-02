class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :approximate_age, :sex, :status
  belongs_to :shelter

  def self.sort_by_status
    Pet.order(:status)
  end

  def self.adoptable
    Pet.where(status: "adoptable")
  end

  def self.pending
    Pet.where(status: "pending")
  end
end
