class Restaurant < ActiveRecord::Base

	validates_uniqueness_of :name
	
	validates_presence_of :name
	validates_presence_of :description
	validates_presence_of :owner

	mount_uploader :picture, PictureUploader

	belongs_to :owner
	has_many :reservations,  dependent: :destroy
end
