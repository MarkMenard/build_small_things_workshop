require 'spec_helper'

describe PageBuilder do

  let(:page) { Page.new("<p>PAGE_CONTENT</p>", {'Test' => true}) }

  describe "building pseudo markup" do
    describe "without the suite setup" do
      # Example of output from building the psuedo markup:
      #
      # !include -setup .PAGE_SETUP_PATH
      # PAGE_CONTENT
      # !include -teardown .PAGE_TEARDOWN_PATH

      let(:built_content) { PageBuilder.build_pseudo_markup(page, false) }

      it "includes the page content" do
        expect(built_content).to match(/^<p>PAGE_CONTENT<\/p>$/)
      end

      it "includes the page setup" do
        expect(built_content).to match(/^!include -setup .PAGE_SETUP_PATH$/)
      end
      it "includes the page teardown" do
        expect(built_content).to match(/^!include -teardown .PAGE_TEARDOWN_PATH$/)
      end

      it "does not include the suite setup" do
        expect(built_content).to_not match(/^!include -setup .SUITE_SETUP$/)
      end

      it "does not include the suite teardown" do
        expect(built_content).to_not match(/^!include -teardown .SUITE_TEARDOWN$/)
      end

    end

    describe "with suite setup" do
      # Example of output from building the psuedo markup:
      #
      # !include -setup .SUITE_SETUP_PATH
      # !include -setup .PAGE_SETUP_PATH
      # PAGE_CONTENT
      # !include -teardown .PAGE_TEARDOWN_PATH
      # !include -teardown .SUITE_TEARDOWN_PATH

      let(:built_content) { PageBuilder.build_pseudo_markup(page, true) }

      it "includes the page content" do
        expect(built_content).to match(/^<p>PAGE_CONTENT<\/p>$/)
      end

      it "includes the page setup" do
        expect(built_content).to match(/^!include -setup .PAGE_SETUP_PATH$/)
      end

      it "includes the page teardown" do
        expect(built_content).to match(/^!include -teardown .PAGE_TEARDOWN_PATH$/)
      end

      it "includes the suite setup" do
        expect(built_content).to match(/^!include -setup .SUITE_SETUP_PATH$/)
      end

      it "includes the suite teardown" do
        expect(built_content).to match(/^!include -teardown .SUITE_TEARDOWN_PATH$/)
      end
    end
  end


end