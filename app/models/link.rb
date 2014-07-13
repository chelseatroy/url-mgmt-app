class Link < ActiveRecord::Base
  
  validates :slug, presence: true
  validates :target_url, presence: true

  belongs_to :user
  has_many :visits

  def standardize_target_url!
    self.target_url.gsub!("http://", "")
    self.target_url.gsub!("https://", "")
  end

  def visit_count
    self.visits.count
  end

end
