class PageCrawlerImpl
  def self.inherited_page (page_type, page)
    return Page.new("SUITE_SETUP", :name => SuiteResponder::SUITE_SETUP_NAME ) if page_type == SuiteResponder::SUITE_SETUP_NAME
    return Page.new("SUITE_TEARDOWN", :name => SuiteResponder::SUITE_TEARDOWN_NAME) if page_type == SuiteResponder::SUITE_TEARDOWN_NAME
    return Page.new("PAGE_SETUP", :name => "PAGE_SETUP") if page_type == 'SetUp'
    return Page.new("PAGE_TEARDOWN", :name => "PAGE_TEARDOWN") if page_type == 'TearDown'
  end

  def full_path (page)
    return "SUITE_SETUP_PATH" if page.attributes[:name] == SuiteResponder::SUITE_SETUP_NAME
    return "SUITE_TEARDOWN_PATH" if page.attributes[:name] == SuiteResponder::SUITE_TEARDOWN_NAME
    return "PAGE_SETUP_PATH" if page.attributes[:name] == "PAGE_SETUP"
    return "PAGE_TEARDOWN_PATH" if page.attributes[:name] == "PAGE_TEARDOWN"
  end
end
