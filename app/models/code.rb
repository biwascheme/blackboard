class Code < ActiveRecord::Base
  # Model
  belongs_to :user

  validates_presence_of :title, :body, :user

  has_ancestry

  default_scope order: 'updated_at DESC'

  # View
  paginates_per 50

  # Class methods
  def self.recent(n)
    Code.limit(n)
  end

  # Returns randomly selected instance of Code.
#  def self.sample
#    Code.first(:offset => rand(Code.count))
#  end
end
