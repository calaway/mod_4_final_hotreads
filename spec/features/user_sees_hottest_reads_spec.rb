require 'rails_helper'

RSpec.feature "User visits root path", type: :feature do
  context "all reads are from today" do
    scenario "they see the 10 most read links in order of read quantity" do
      (1...11).each do |index|
        link = Link.create(url: "http://example#{index}.com")
        index.times do
          link.reads.create
        end
      end

      visit root_path

      expected_content = "Hot Reads! http://example10.com http://example9.com http://example8.com http://example7.com http://example6.com http://example5.com http://example4.com http://example3.com http://example2.com http://example1.com"
      expect(page).to have_text(expected_content)
    end
  end

  context "some reads are more than a day old" do
    scenario "they see only reads from today" do
      Link.create(url: "http://new.com").reads.create(created_at: Time.now())
      Link.create(url: "http://old.com").reads.create(created_at: 25.hours.ago)

      visit root_path

      expect(page).to have_text("http://new.com")
      expect(page).to_not have_text("http://old.com")
    end
  end
end
