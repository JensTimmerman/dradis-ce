require 'rails_helper'

describe 'User notifications', js: true do
  subject { page }

  before do
    login_to_project_as_user
    visit root_path
  end

  it 'can view the notifcation bell' do
    within '.navbar' do
      expect(page).to have_css '.notifications.dropdown'
    end
  end

  describe 'notifications list with ajax' do
    it 'opens the dropdown after click' do
      find('[data-id="js-notifications-dropdown"]').click
      expect(find('[data-id="js-notification-container"]')).to_not be_nil
    end

    context 'the user has no notifications' do
      it 'shows an empty dropdown' do
        find('[data-id="js-notifications-dropdown"]').click

        expect(find('.no-content', text: 'You have no notifications yet.')).to_not be_nil
      end
    end

    context 'the user has some notifications' do
      it 'shows the notification list' do
        issue = create(:issue, text: 'Test issue')
        create(:notification, notifiable: issue, actor: @logged_in_as, recipient: @logged_in_as)

        find('[data-id="js-notifications-dropdown"]').click

        expect(page).to have_content "#{@logged_in_as.email} commented"
      end
    end
  end
end