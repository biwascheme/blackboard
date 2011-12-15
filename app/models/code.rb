class Code < ActiveRecord::Base
  # Association
  belongs_to :user

  # Validation
  validates_presence_of :title, :body, :user

  # Plugin
  has_ancestry

  # View
  paginates_per 50

  # Returns randomly selected instance of Code.
#  def self.sample
#    Code.first(:offset => rand(Code.count))
#  end
end
