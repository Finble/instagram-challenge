require 'rails_helper'

feature 'pictures' do
  
  context 'no pictures have been added' do
    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link 'Add a picture'
    end
  end

  context 'pictures have been added' do
	  before do
	    Picture.create(name: 'Holiday')
	  end

	  scenario 'display pictures' do
	    visit '/pictures'
	    expect(page).to have_content('Holiday')
	    expect(page).not_to have_content('No pictures yet')
	  end
	end

	context 'creating pictures' do
	  
	  scenario 'prompts user to fill out a form, then displays the new picture' do
	    visit '/pictures'
	    click_link 'Add a picture'
	    fill_in 'Name', with: 'Holiday'
	    click_button 'Create Picture'
	    expect(page).to have_content 'Holiday'
	    expect(current_path).to eq '/pictures'
  	end
  end

  context 'viewing restaurants' do

	  let!(:holiday){Picture.create(name:'Holiday')}

	  scenario 'lets a user view a picture' do
	   visit '/pictures'
	   click_link 'Holiday'
	   expect(page).to have_content 'Holiday'
	   expect(current_path).to eq "/pictures/#{holiday.id}"
  	end
	end

	context 'editing pictures' do

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
end