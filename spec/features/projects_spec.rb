require 'rails_helper'

describe 'projects' do
  context 'sharing' do
    let!(:user_to_share_with) { FactoryGirl.create(:user) }
    let!(:project_owner) { FactoryGirl.create(:user) }
    let!(:project) { FactoryGirl.create(:project, user: project_owner, name: 'project shared') }

    before do
      login_as(project_owner, scope: :user)
      FactoryGirl.create(:project, user: project_owner, name: 'project not shared')
      visit projects_path
      click_button "share_project_#{project.id}"
    end

    it 'can share a project with another user' do
      fill_in "user_email_to_share_with_#{project.id}", with: user_to_share_with.email
      click_button "share_submit_button_#{project.id}"
      logout(:user)
      login_as(user_to_share_with, scope: :user)
      visit projects_path
      expect(page).to have_link('project shared')
      expect(page).to_not have_button("share_project_#{project.id}")
      expect(page).to_not have_link('project not shared')
    end

    it 'gives meaningful error with invalid email' do
      fill_in "user_email_to_share_with_#{project.id}", with: 'invalid_email@invalid.com'
      click_button "share_submit_button_#{project.id}"
      expect(page).to have_content("Sorry we could not find that user's email in our database.")
    end
  end
end