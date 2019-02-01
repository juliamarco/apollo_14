require 'rails_helper'

RSpec.describe 'when visitor visits songs index', type: :feature do

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
      end
    end

    it 'displays a list of the space missions in alphabetical order for each astronaut' do
      neil = Astronaut.create(name: "Neil Armstrong", age: 37, job: "Commander")
      buzz = Astronaut.create(name: "Buzz Aldrin", age: 55, job: "Pilot")
      mission_1 = neil.missions.create(title: "Apollo 11", time_in_space: 22)
      mission_2 = neil.missions.create(title: "Gemini 5", time_in_space: 12)
      mission_3 = buzz.missions.create(title: "Apollo 11", time_in_space: 22)

      visit astronauts_path

      save_and_open_page
      within "#space-missions-#{neil.id}" do
        expect(page).to have_content("Missions: #{neil.missions.title}")
        expect(page).to_not have_content("Missions: #{buzz.missions.title}")
      end

      within "#space-missions-#{buzz.id}" do
        expect(page).to have_content("Missions: #{buzz.missions.title}")
        expect(page).to_not have_content("Missions: #{neil.missions.title}")

      end

  end
end
