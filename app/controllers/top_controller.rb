class TopController < ApplicationController
  def index
    @code = Code.new
    @code.body = '(print "Hello, world!")'
  end
end
