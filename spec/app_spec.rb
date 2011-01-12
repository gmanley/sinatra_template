require "spec_helper"

describe "index" do
  include TestHelper

  it "should render successfully" do
    get "/"
    last_response.should be_ok
  end

end