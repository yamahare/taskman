require 'rails_helper'

RSpec.feature 'タスクの表示順', type: :feature do
  describe 'indexページ' do
    let(:valid_attrs) do
      [{ name: '最初につくったタスク' },
       { name: '2番めにつくったタスク' },
       { name: '3番めにつくったタスク' }]
    end
    let(:task_names) { page.all('.task_name') }
    before do
      valid_attrs.each { |val| Task.create!(val) }
      visit '/'
    end

    it '作成日の降順に表示されること' do
      expect(task_names[0].text).to eq valid_attrs[2][:name]
      expect(task_names[1].text).to eq valid_attrs[1][:name]
      expect(task_names[2].text).to eq valid_attrs[0][:name]
    end
  end
end
