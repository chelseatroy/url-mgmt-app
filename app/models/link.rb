class Link < ActiveRecord::Base
  
  validates :slug, presence: true
  validates :target_url, presence: true
  validates :slug, uniqueness: true

  belongs_to :user
  has_many :visits

  def standardize_target_url!
    self.target_url.gsub!("http://", "")
    self.target_url.gsub!("https://", "")
  end

  def visit_count
    self.visits.count
  end

  def map_url
    url = "http://maps.googleapis.com/maps/api/staticmap?size=600x300&maptype=roadmap>"
    self.visits.each do |visit|
     url = url + "&markers=color:blue%7C#{visit.latitude},#{visit.longitude}"
    end
    return url
  end 

  def total_visits_to_target_url
    total = 0
    Link.where(:target_url => self.target_url, :user_id => self.user_id).each do |link|
      total += link.visit_count 
    end 
    total
  end
 
  def target_url_stats
    stats_hash = {}
    Link.where(:target_url => self.target_url, :user_id => self.user_id).each do |link|
      stats_hash.merge!({link.description => link.visit_count})
    end 
    stats_hash
  end

end
