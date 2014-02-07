require 'spec_helper'

describe PageBuilder do

  let(:page) { Page.new("PAGE_CONTENT", {'Test' => true}) }

  describe "building HTML page" do
    describe "without the suite setup" do
      it "includes the page content" do
        expected_result = "<html>\n!include -setup .PAGE_SETUP\nPAGE_CONTENT\n!include -teardown .PAGE_TEARDOWN\n</html>"
        expect(PageBuilder.testable_html(page, false)).to match(/PAGE_CONTENT/)
      end

      it "includes the page setup" do
        expect(PageBuilder.testable_html(page, false)).to match(/!include -setup .PAGE_SETUP/)
      end
      it "includes the page teardown" do
        expect(PageBuilder.testable_html(page, false)).to match(/!include -teardown .PAGE_TEARDOWN/)
      end
    end

    describe "with suite setup" do
      it "includes the suite setup" do
        expected_result = "<html>\n!include -setup .SUITE_SETUP\n!include -setup .PAGE_SETUP\nPAGE_CONTENT\n!include -teardown .PAGE_TEARDOWN\n!include -teardown .SUITE_TEARDOWN\n</html>"
        expect(PageBuilder.testable_html(page, true)).to match(/!include -setup .SUITE_SETUP/)
      end

      it "includes the suite teardown" do
        expect(PageBuilder.testable_html(page, true)).to match(/!include -teardown .SUITE_TEARDOWN/)
      end
    end
  end


end