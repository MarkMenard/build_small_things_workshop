require 'spec_helper'

describe "HTML utilities" do
  it "does something" do
    expect(HtmlUtil.testable_html(Page.new("", {'Test' => ''}), true)).to eq("<html></html>")
  end
end