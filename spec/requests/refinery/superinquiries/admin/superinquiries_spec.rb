# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Superinquiries" do
    describe "Admin" do
      describe "superinquiries" do
        login_refinery_user

        describe "superinquiries list" do
          before do
            FactoryGirl.create(:superinquiry, :title => "UniqueTitleOne")
            FactoryGirl.create(:superinquiry, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.superinquiries_admin_superinquiries_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.superinquiries_admin_superinquiries_path

            click_link "Add New Superinquiry"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Superinquiries::Superinquiry.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Superinquiries::Superinquiry.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:superinquiry, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.superinquiries_admin_superinquiries_path

              click_link "Add New Superinquiry"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Superinquiries::Superinquiry.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:superinquiry, :title => "A title") }

          it "should succeed" do
            visit refinery.superinquiries_admin_superinquiries_path

            within ".actions" do
              click_link "Edit this superinquiry"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:superinquiry, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.superinquiries_admin_superinquiries_path

            click_link "Remove this superinquiry forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Superinquiries::Superinquiry.count.should == 0
          end
        end

      end
    end
  end
end
