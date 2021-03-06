class Movie < ActiveRecord::Base
  has_many :reviews , dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :fans,through: :favorites,source: :user
  has_many :characterizations,dependent: :destroy
  has_many :genres ,through: :characterizations

  RATINGS=%w(G PG PG-13 R NC-17)
  validates :title,:released_on,:duration,presence: true
  validates :description,length: {minimum:25}
  validates :total_gross,numericality:{greater_equal_to:0}
  validates :image_file_name,allow_blank:true,format:{
                                with:/\w+\.(jpg|png|jpeg|jif)\z/i,
                                message: "must be a GIF or JPG or PNG or JPEG image"
                            }
  validates :rating,inclusion:{in: RATINGS}

  scope :released,->{where("released_on <= ?", Time.now).order("released_on desc")}
  scope :hits,->{where('total_gross >= 300000000').order('total_gross desc')}
  scope :flops,->{where('total_gross<50200000').order('total_gross asc')}
  scope :upcoming,->{where('released_on >?',Time.now).order(released_on: :asc)}
  scope :rated,->(rating='PG'){released.where(rating: :rating)}

 # def self.released
  #  where("released_on <= ?", Time.now).order("released_on desc")
  #end
  
 # def self.hits
  #  where('total_gross >= 300000000').order('total_gross desc')
  #end
  
 # def self.flops
  #  where('total_gross < 10000000').order('total_gross asc')
  #end
  
  def self.recently_added
    order('created_at desc').limit(3)
  end
  
  def flop?
    total_gross.blank? || total_gross < 50000000
  end
  def average_stars
    reviews.average(:stars)
  end

  def recent_reviews
    reviews.order('created_at desc').limit(2)
  end


end
