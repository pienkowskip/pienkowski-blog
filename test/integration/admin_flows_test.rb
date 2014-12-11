require 'test_helper'

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include UserTestHelper

  test 'login and add a directory' do
    # Access user login page
    visit '/user/login'
    assert find('h1').has_content? 'Logowanie'

    # Login as admin
    fill_in 'login', with: users(:default).username
    fill_in 'password', with: default_user.password
    click_button 'Zaloguj'
    assert find('h1.page-title').has_content? 'Dashboard'
    assert_equal '/admin', current_path

    # Access directories
    click_link 'Biblioteka mediów'
    find('h1.page-title')
    assert find('h1.page-title').has_content? 'Katalogi mediów'
    assert_equal '/admin/directories', current_path

    # Add new directories
    add_and_assert_directory 'Główny katalog'
    add_and_assert_directory 'Podrzędny katalog', 'Główny katalog', '/Główny katalog'

    # Log out
    click_link 'Wyloguj'
    assert find('h1').has_content? 'Logowanie'
    assert_equal '/user/login', current_path
    assert find('div.dialog-content.notice-dialog').has_content? 'Zostałeś wylogowany poprawnie.'

    # Try access admin zone
    visit '/admin'
    assert find('h1').has_content? 'Logowanie'
    assert_equal '/user/login', current_path
    assert find('div.dialog-content.alert-dialog').has_content? 'Musisz być zalogowany, aby używać tej sekcji.'
  end

  private

  def add_and_assert_directory(name, parent = nil, parent_fp = '')
    assert_difference ->{ Directory.count }, +1 do
      select parent.nil? ? '<brak>' : parent, from: 'Katalog nadrzędny'
      fill_in 'Nazwa', with: name
      click_button 'Utwórz'
    end
    fp = parent_fp + '/' + name
    table = find('table')
    # UI validation
    assert table.has_content? name
    assert table.has_content? fp
    assert_equal table.all('tr').length, Directory.count + 1
    assert_equal '/admin/directories', current_path
    # data validation
    dir = Directory.find_by_fullpath fp
    parent_id = parent.nil? ? nil : Directory.find_by_fullpath(parent_fp).id
    assert_equal dir.name, name
    assert_equal dir.fullpath, fp
    assert_equal dir.parent_id, parent_id
  end
end
