class Owner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   validates_presence_of :name
   
   has_many :restaurants, dependent: :destroy

   def owns?(restaurant) 
   		restaurant.owner == self
   end

end
