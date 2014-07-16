require 'googlestaticmap'

class Restaurant < ActiveRecord::Base

	attr_accessor :picture, :picture_cache

	validates_uniqueness_of :name
	validates :name, presence: true
	validates :description, presence: true

	mount_uploader :picture, PictureUploader

	belongs_to :owner

	def address_url
		map = GoogleStaticMap.new(:api_key => ENV['GOOGLE_STATIC_MAPS_API_KEY'])
		address << street
		address << ', '
		address << city
		address << ', '
		address << state
		address << zipCode
		map.markers << MapMarker.new(:color => "blue", :location => MapLocation.new(:address => "#{address}"))
		print map.get_map
	end
end
