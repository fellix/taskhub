require 'spec_helper'

feature "manages a list" do
  background do
    @user = Factory.create(:user)
    @other = Factory.create(:other)
    login_as @user
  end
  scenario "my home page" do
    page.should have_content("Sem listas de tarefas")
  end
  scenario "create a new list" do
    create_a_list
    page.should have_content("Coisas a fazer")
  end

  scenario "viewing data from a list" do
    create_a_list
    click_link "Coisas a fazer"
    page.should have_content("Coisas a fazer")
  end

  scenario "can't view a list when has not logged in" do
    create_a_list
    logout
    visit '/lists/1'
    page.should have_content("Sign in")
  end

  scenario "can view a public list from another user" do
    create_a_list
    logout
    login_as @other
    visit '/lists/1'
    page.should have_content("Coisas a fazer")
  end

  scenario "can't view a private list from another user" do
    create_a_list false
    logout
    login_as @other
    visit '/lists/1'
    page.should have_content("Acesso negado")
  end

  scenario "can't watch my lists" do
    create_a_list
    click_link "Coisas a fazer"
    page.should_not have_content("Observar")
  end

  scenario "can watch a public list from another user" do
    create_a_list
    logout
    login_as @other
    visit '/lists/1'
    click_link "Observar"
    page.should have_content("Coisas a fazer")
  end

  scenario "can't watch a list two times" do
    create_a_list
    logout
    login_as @other
    visit '/lists/1'
    click_link "Observar"
    visit '/lists/1'
    page.should_not have_content("Observar")
  end

  def create_a_list(public=true)
    click_link "Criar uma nova lista de tarefas"
    within "#new_list" do
      fill_in "Name", :with => "Coisas a fazer"
      fill_in "Title", :with => "Tarefa 1"
      check "Public" if public
      uncheck "Public" unless public
      click_button "Salvar"
    end
  end

  def login_as(user)
    visit '/'
    click_link "Login"
    within("#user_new") do
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
    end
  end

  def logout
    visit '/'
    click_link "Logout"
  end
end