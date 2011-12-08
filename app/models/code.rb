class Code < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :body, :user

  # View
  #default_scope :order => 'created_at DESC'
  paginates_per 10

end
