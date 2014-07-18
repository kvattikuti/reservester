class Restaurant < ActiveRecord::Base

	validates_uniqueness_of :name
	validates :name, presence: true
	validates :description, presence: true
	validates_presence_of :owner

	mount_uploader :picture, PictureUploader

	belongs_to :owner
end
