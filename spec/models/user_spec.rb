require 'rails_helper'

describe User do
  describe '#projects' do
    it 'works' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:project, name: 'should not appear in results')
      project = FactoryGirl.create(:project, name: 'assigned')
      project.users_shared_with << user
      FactoryGirl.create(:project, user: user, name: 'owned')
      expect(user.projects.map(&:name).to_set).to eq(['assigned', 'owned'].to_set)
    end
  end
end