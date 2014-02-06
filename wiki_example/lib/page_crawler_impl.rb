class PageCrawlerImpl
  def self.inherited_page (page_type, page)
    return Page.new("") if page_type == SuiteResponder::SUITE_SETUP_NAME
    return Page.new("") if page_type == SuiteResponder::SUITE_TEARDOWN_NAME
  end

  def full_path (page)
    ""
  end
end
