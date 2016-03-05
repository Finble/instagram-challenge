require 'rails_helper'

feature 'comments' do
  before {Picture.create name: 'Holiday'}

  scenario 'allows users to leave a comment using a form' do
     visit '/pictures'
     click_link 'Comment Holiday'
     fill_in "Comments", with: "Funny!"
     # select 'like', from: 'Like'
     click_button 'Leave Comment'

     expect(current_path).to eq '/pictures'
     expect(page).to have_content('Funny!')
  end

end
