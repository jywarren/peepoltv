class Video < ActiveRecord::Base

	validates_presence_of :title,:author,:latitude,:longitude
	# validates :name, :presence => true , :message => 'Name cannot be blank, Task not saved'
	has_many :tags

end
