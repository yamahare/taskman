require 'rails_helper'

RSpec.feature 'タスクの表示順', type: :feature do
  describe 'indexページ' do
    let(:valid_attrs) do
      [{ name: '最初につくったタスク', created_at: DateTime.now,     end_date: Date.today,           priority: 3},
       { name: '2番めにつくったタスク',created_at: DateTime.now + 1, end_date: Date.today.next_year, priority: 1},
       { name: '3番めにつくったタスク',created_at: DateTime.now + 2, end_date: Date.today.tomorrow , priority: 2}]
    end
    let(:task_names) { page.all('.task_name') }
    before do
      valid_attrs.each { |val| Task.create!(val) }
      visit '/'
    end

    context 'indexに遷移したとき' do
      it '作成日の降順に表示されること' do
        expect(task_names[0].text).to eq valid_attrs[2][:name]
        expect(task_names[1].text).to eq valid_attrs[1][:name]
        expect(task_names[2].text).to eq valid_attrs[0][:name]
      end
    end

    context '終了日の▼をクリックした場合' do
      before do
        page.find('th', text:'終了日').click_link('▼')
      end
      it '終了日の降順に表示されること' do
        expect(task_names[0].text).to eq valid_attrs[1][:name]
        expect(task_names[1].text).to eq valid_attrs[2][:name]
        expect(task_names[2].text).to eq valid_attrs[0][:name]
      end
    end

    context '終了日の▲をクリックした場合' do
      before do
        page.find('th', text:'終了日').click_link('▲')
      end
      it '終了日の昇順に表示されること' do
        expect(task_names[0].text).to eq valid_attrs[0][:name]
        expect(task_names[1].text).to eq valid_attrs[2][:name]
        expect(task_names[2].text).to eq valid_attrs[1][:name]
      end
    end

    context '優先度の▼をクリックした場合' do
      before do
        page.find('th', text:'優先度').click_link('▼')
      end
      it '優先度の降順に表示されること' do
        expect(task_names[0].text).to eq valid_attrs[0][:name]
        expect(task_names[1].text).to eq valid_attrs[2][:name]
        expect(task_names[2].text).to eq valid_attrs[1][:name]
      end
    end

    context '優先度の▲をクリックした場合' do
      before do
        page.find('th', text:'優先度').click_link('▲')
      end
      it '優先度の昇順に表示されること' do
        expect(task_names[0].text).to eq valid_attrs[1][:name]
        expect(task_names[1].text).to eq valid_attrs[2][:name]
        expect(task_names[2].text).to eq valid_attrs[0][:name]
      end
    end
  end
end
