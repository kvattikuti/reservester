class Restaurant < ActiveRecord::Base

	validates_uniqueness_of :name

	validates_presence_of :name
	validates_presence_of :description
	validates_presence_of :owner

	mount_uploader :picture, PictureUploader

	belongs_to :owner
	has_many :reservations, dependent: :destroy, inverse_of: :restaurant
	has_and_belongs_to_many :categories

	accepts_nested_attributes_for :reservations, allow_destroy: true, reject_if: :all_blank

	def category_list
		categories.collect { |c| c.id }
	end

	def category_list= category_ids
		categories.delete_all
		category_ids.each do |id|
			categories << Category.find(id)
		end
	end
end
