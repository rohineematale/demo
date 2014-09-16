class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :areas, :first_name, :last_name
  # attr_accessible :title, :body

  before_create :set_areas

  def set_areas
  	self.areas = self.areas.join(",")
  end

  def name
  	name = self.first_name
    name = name + self.last_name unless self.last_name.blank?
    return name
  end

  def cities
  	self.areas.split(",").compact if self.areas.present?
  end
end
