require 'test_helper'

class TopWriteCodeTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "clicking 'Run' evals Scheme code" do
    visit '/'

    click_button 'Run'

    within_frame('stage') do
      assert find('#bs-console').text == 'Hello, world!',
        "should have output of the Scheme code"
    end
  end
end
