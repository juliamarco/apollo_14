require 'rails_helper'

describe 'as a visitor' do
  context 'when I visit /astronauts' do
    it "displays a list of astronauts" do
      neil = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create(name: "Buzz Aldrin", age: 55, job: "Pilot")

      visit astronauts_path

      within "#astronaut-#{neil.id}" do

        expect(page).to have_content(neil.name)
        expect(page).to have_content("Age: #{neil.age}")
        expect(page).to have_content("Job: #{neil.job}")

        expect(page).to_not have_content("Age: #{buzz.age}")
        expect(page).to_not have_content("Job: #{buzz.job}")
      end

      within "#astronaut-#{buzz.id}" do

        expect(page).to have_content(buzz.name)
        expect(page).to have_content("Job: #{buzz.job}")
        expect(page).to have_content("Age: #{buzz.age}")

        expect(page).to_not have_content("Age: #{neil.age}")
        expect(page).to_not have_content("Job: #{neil.job}")
      end
    end

    it 'shows the average age of all astronauts' do
      neil = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create(name: "Buzz Aldrin", age: 55, job: "Pilot")

      visit astronauts_path

      within "#average-age" do

        expect(page).to have_content(46)
        save_and_open_page
        
      end
    end

  end
end
