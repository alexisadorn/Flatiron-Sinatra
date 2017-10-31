class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
