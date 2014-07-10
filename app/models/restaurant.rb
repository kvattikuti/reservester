class Restaurant < ActiveRecord::Base

	attr_accessor :picture, :picture_cache

	validates_uniqueness_of :name
	validates :name, presence: true
	validates :description, presence: true

	mount_uploader :picture, PictureUploader

end
