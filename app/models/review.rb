class Review < ActiveRecord::Base
  belongs_to :movie
  validates :name ,presence: true
  validates :stars,presence: true, numericality: { greater_than_or_equal_to: 0}


end

