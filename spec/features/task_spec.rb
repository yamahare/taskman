require 'rails_helper'

RSpec.feature 'タスク操作', type: :feature do
  describe 'トップページ' do

    let(:valid_attr) { { name: '最初のタスク' } }
    let(:valid_another_attr) { { name: '洗濯物を干す', detail: '明日までになんとかしたい' } }
    let!(:task) { Task.create! valid_attr }
    before do
      visit '/'
    end

    it 'indexにアクセスして表示が正常' do
      expect(page).to have_text('タスクマン')
      expect(page).to have_text('最初のタスク')
    end

    it 'タスクが新規作成できること' do
      click_on '新規作成'
      expect(page).to have_text('新規タスク追加')
      fill_in 'task[name]', with: valid_another_attr[:name]
      fill_in 'task[detail]', with: valid_another_attr[:detail]
      expect { click_button '保存' }.to change(Task, :count).by(1)
    end

    it 'タスクが編集できること' do
      find_link('編集', option = { href: "/tasks/#{task.id}/edit" }).click
      expect(page).to have_text('タスク編集')
      fill_in 'task[name]', with: valid_another_attr[:name]
      fill_in 'task[detail]', with: valid_another_attr[:detail]
      click_button '保存'
      task.reload
      expect(task.name).to match(valid_another_attr[:name])
    end

    it 'タスクが削除できること' do
      expect { find_link('削除', option = { href: "/tasks/#{task.id}" }).click }.to change(Task, :count).by(-1)
    end
  end
end
