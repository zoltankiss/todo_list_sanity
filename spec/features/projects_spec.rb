require 'rails_helper'

describe 'projects' do 
  it 'can share a project with another user' do
    project_owner = FactoryGirl.create(:user)
    user_to_share_with = FactoryGirl.create(:user)
    login_as(project_owner, scope: :user)
    project = FactoryGirl.create(:project, user: project_owner, name: 'project shared')
    FactoryGirl.create(:project, user: project_owner, name: 'project not shared')
    visit projects_path
    click_button "share_project_#{project.id}"
    fill_in "user_url_to_share_with_#{project.id}", with: user_url(user_to_share_with)
    click_button "share_submit_button_#{project.id}"
    logout(:user)
    login_as(user_to_share_with, scope: :user)
    visit projects_path
    expect(page).to have_link('project shared')
    expect(page).to_not have_button("share_project_#{project.id}")
    expect(page).to_not have_link('project not shared')
  end
end