class Code < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body, :user

  # View
  paginates_per 50

  # Returns randomly selected instance of Code.
#  def self.sample
#    Code.first(:offset => rand(Code.count))
#  end
end
