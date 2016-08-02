require 'test_helper'

class CategoriesTest < ActionDispatch::IntegrationTest
  test 'Create a new category' do
    login_as(users(:user1))
    visit categories_path
    fill_in('category[name]', with: 'テストカテゴリ')
    assert_difference 'Category.count', 1 do
      click_button '追加する'
    end
    assert page.has_content?('追加しました')
    category = Category.last
    assert_equal 'テストカテゴリ', category.name
  end

  test 'Edit category' do
    login_as(users(:user1))
    visit categories_path
    first(:link, '編集').click
    fill_in('category[name]', with: 'テストカテゴリ')
    click_button '更新する'
    category = Category.find_by(name: 'テストカテゴリ')
    assert page.has_content?('編集しました')
    assert category
    assert_equal 'テストカテゴリ', category.name
  end

  test 'Delete category' do
    login_as(users(:user1))
    visit categories_path
    assert_difference 'Category.count', -1 do
      first(:link, '削除').click
    end
  end
end
