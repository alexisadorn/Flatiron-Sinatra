class Genre < ActiveRecord::Base
  has_many :artists, through: :songs
  has_many :song_genres
  has_many :songs, through: :song_genres
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
