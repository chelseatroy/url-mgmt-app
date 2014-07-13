class Visit < ActiveRecord::Base

  belongs_to :link

  geocoded_by :ip_address  
  after_validation :geocode
      
end
