class TopController < ApplicationController
  def index
    @code = Code.new
    @code.body = '(print "Hello, world!")'

    @codes = Code.recent(5)
  end
end
