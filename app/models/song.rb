class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "cannot be repeated by the same artist in the same year"
  }
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
  end
  #   validate :validate_relase_year 

  def released?
    released
  end
  
# another solution 
#   def validate_release_year
#     if released == true && release_year == ""
#       errors.add(:release_year, "must specify what year the song was released")
#       return false
#     elsif released == true && release_year.class != Fixnum
#       errors.add(:release_year, "must be a valid integer")
#       return false
#     elsif released == true && release_year > Date.today.year
#       errors.add(:release_year, "cannot be greater than the current year")
#       return false
#     elsif released == true && release_year <= Date.today.year
#       return true
#     elsif released == false && release_year == ""
#       return true
#     end
#   end 
end
