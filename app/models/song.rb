class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true
  validates :title, uniqueness: { scope: [:release_year, :artist_name], message: 'Already in use by same artist in same year' }
  # validate :year_unique?
  validate :release_year?

  # def year_unique?
  #   unless Song.find_by(artist_name: artist_name, title: title, release_year: release_year)
  #     errors.add(:title, 'Already in use by same artist in same year')
  #   end
  # end

  def release_year?
    if released && release_year.nil?
      errors.add(:release_year, 'Must provide release year if song released')
    end
    if release_year && release_year > Time.now.year
      errors.add(:release_year, 'Release year must be less than or equal to current year')
    end
  end

end
