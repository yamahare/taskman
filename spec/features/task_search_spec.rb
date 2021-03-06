require 'rails_helper'

RSpec.feature 'タスクの絞り込み', type: :feature do
  describe 'indexページ' do
    let(:valid_attrs) do
      [{ name: '未着手', status: 0},
       { name: '着手',   status: 1},
       { name: '着手2',  status: 1},
       { name: '完了',   status: 2}]
    end
    let(:task_names) { page.all('.task_name') }
    before do
      valid_attrs.each { |val| Task.create!(val) }
      visit '/'
    end

    context 'indexに遷移したとき' do
      it 'すべてのタスクが表示されていること' do
        expect( task_names.length ).to eq valid_attrs.length
        expect( task_names.map { |task| task.text } ).to match_array valid_attrs.map{ |val| val[:name] }
      end
    end

    context '「すべて」をクリックしたとき' do
      before { click_link('すべて') }
      it 'すべてのタスクが表示されていること' do
        expect( task_names.length).to eq valid_attrs.length
        expect( task_names.map { |task| task.text } ).to match_array valid_attrs.map{ |val| val[:name] }
      end
    end

    context '「未着手」をクリックしたとき' do
      before { page.find('a.nav-link', text: '未着手').click }
      it 'ステータスが未着手のタスクが表示されていること' do
        expect( task_names.length).to eq valid_attrs.map { |val| val[:status] }.count(0) # ステータスが０のものを数える
        expect( task_names.map { |task| task.text } ).to match_array valid_attrs.select{ |n| n[:status] == 0 }.map { |n| n[:name] }
      end
    end

    context '「着手」をクリックしたとき' do
      before { page.find('a.nav-link', text: /\A着手\z/).click }
      it 'ステータスが着手のタスクが表示されていること' do
        expect( task_names.length).to eq valid_attrs.map { |val| val[:status] }.count(1) # ステータスが1のものを数える
        expect( task_names.map { |task| task.text } ).to match_array valid_attrs.select{ |n| n[:status] == 1 }.map { |n| n[:name] }
      end
    end

    context '「完了」をクリックしたとき' do
      before { page.find('a.nav-link', text: /\A完了\z/).click }
      it 'ステータスが完了のタスクが表示されていること' do
        expect( task_names.length).to eq valid_attrs.map { |val| val[:status] }.count(2) # ステータスが1のものを数える
        expect( task_names.map { |task| task.text } ).to match_array valid_attrs.select{ |n| n[:status] == 2 }.map { |n| n[:name] }
      end
    end
  end
end
