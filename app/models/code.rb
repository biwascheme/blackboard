class Code < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body, :user

  # View
  paginates_per 50

end
