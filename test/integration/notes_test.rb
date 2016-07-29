require 'test_helper'

class NotesTest < ActionDispatch::IntegrationTest
  test "Create a new post" do
    login_as(users(:user1))
    visit notes_path
    click_link '新規投稿'
    fill_in('note[title]', with: '記事')
    fill_in('note[content]', with: 'こんにちわ')
    select('テスト1', :from => 'note[category_id]')
    assert_difference 'Note.count', 1, '投稿が作成されるべき' do
      click_button '登録する'
    end

    assert page.has_content?('投稿されました')
    note = Note.last
    assert_equal '記事', note.title
    assert_equal 'こんにちわ', note.content
    assert_equal 'テスト1', note.category.name
  end
end
