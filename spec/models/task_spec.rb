require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデルのテスト' do

    context 'タスク名が140文字より多い場合' do
      let(:morethan140) { { name:  "aaaaaaaaaaaaaaaaaaaaaaaaaa\
                                      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
                                      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
                                      aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" } }

      it '保存できないこと' do
        expect(Task.new morethan140).not_to be_valid
      end
    end

    context 'タスクの終了日が未来日でないと登録できないこと' do
      let(:yesterday) { { end_date:  Date.today.yesterday } }

      it '保存できないこと' do
        expect(Task.new yesterday).not_to be_valid
      end
    end
  end
end
