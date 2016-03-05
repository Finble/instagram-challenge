require 'rails_helper'

# CRUD tests

feature 'pictures' do
  
  context 'no pictures have been added' do  #Starting position - nothing added
    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link 'Add a picture'
    end
  end

  context 'pictures have been added' do #ADDED ==> RETRIEVE/READ
	  before do
	    Picture.create(name: 'Holiday')
	  end

	  scenario 'display pictures' do
	    visit '/pictures'
	    expect(page).to have_content('Holiday')
	    expect(page).not_to have_content('No pictures yet')
	  end
	end

	context 'creating pictures' do #CREATE ==> CREATE/ADD
	  
	  scenario 'prompts user to fill out a form, then displays the new picture' do
	    visit '/pictures'
	    click_link 'Add a picture'
	    fill_in 'Name', with: 'Holiday'
	    click_button 'Create Picture'
	    expect(page).to have_content 'Holiday'
	    expect(current_path).to eq '/pictures'
  	end
  end

  context 'viewing restaurants' do  #VIEW/SHOW ==> READ/VIEW

	  let!(:holiday){Picture.create(name:'Holiday')}

	  scenario 'lets a user view a picture' do
	   visit '/pictures'
	   click_link 'Holiday'
	   expect(page).to have_content 'Holiday'
	   expect(current_path).to eq "/pictures/#{holiday.id}"
  	end
	end

	context 'editing pictures' do #EDIT ==> UPDATE/EDIT

	  before { Picture.create name: 'Holiday' }

	  scenario 'let a user edit a picture' do
	   visit '/pictures'
	   click_link 'Edit Holiday'
	   fill_in 'Name', with: 'Holiday in France'
	   click_button 'Update Picture'
	   expect(page).to have_content 'Holiday in France'
	   expect(current_path).to eq '/pictures'
	  end
	end

	context 'deleting pictures' do  #DELETE ==> DESTROY/DELETE

  before { Picture.create name: 'Holiday' }

  scenario 'removes a picture when a user clicks a delete link' do
    visit '/pictures'
    click_link 'Delete Holiday'
    expect(page).not_to have_content 'Holiday'
    expect(page).to have_content 'Picture deleted successfully'
  end

end
end