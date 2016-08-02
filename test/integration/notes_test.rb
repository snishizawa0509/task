require 'test_helper'

class NotesTest < ActionDispatch::IntegrationTest
  test 'Create a new post' do
    login_as(users(:user1))
    visit notes_path
    click_link '新規投稿'
    fill_in('note[title]', with: '記事')
    fill_in('note[content]', with: 'こんにちわ')
    select('牛1', from: 'note[category_id]')
    assert_difference 'Note.count', 1, '投稿が作成されるべき' do
      click_button '登録する'
    end

    assert page.has_content?('投稿されました')
    note = Note.last
    assert_equal '記事', note.title
    assert_equal 'こんにちわ', note.content
    assert_equal '牛1', note.category.name
  end

  test 'Edit post' do
    login_as(users(:user1))
    visit notes_path
    first(:link, '編集').click
    fill_in('note[title]', with: '記事')
    fill_in('note[content]', with: 'こんにちわ')
    select('牛2', from: 'note[category_id]')
    click_button '更新する'
    note = Note.find_by(title: '記事')
    assert page.has_content?('投稿されました')
    assert note
    assert_equal '記事', note.title
    assert_equal 'こんにちわ', note.content
    assert_equal '牛2', note.category.name
  end

  test 'Delete post' do
    login_as(users(:user1))
    visit notes_path
    assert_difference 'Note.count', -1 do
      first(:link, '削除').click
    end
  end

  test 'Search post1' do
    visit notes_path
    fill_in('word', with: '')
    select('all user', from: 'user_id')
    click_button '検索'
    assert page.has_content?('全体で 15 件')
  end

  test 'Search post2' do
    visit notes_path
    fill_in('word', with: '')
    select('nishizawa', from: 'user_id')
    click_button '検索'
    assert page.has_content?('全体で  5 件')
  end

  test 'Search post3' do
    visit notes_path
    fill_in('word', with: '動物1')
    select('all user', from: 'user_id')
    click_button '検索'
    assert page.has_content?('全体で  3 件')
  end

  test 'Search post4' do
    visit notes_path
    fill_in('word', with: '動物1')
    select('taguchi', from: 'user_id')
    click_button '検索'
    assert page.has_content?('1件　1ページ目のみ')
  end
end
