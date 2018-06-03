require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(name:'洗濯物を干す'),
      Task.create!(name:'宿題をする')
    ])
  end

  it "renders a list of tasks" do
    render
  end
end
