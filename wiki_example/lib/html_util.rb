class HtmlUtil

  def self.testable_html (page_data, include_suite_setup)
    wiki_page = page_data.wiki_page
    buffer = ""
    if page_data.has_attribute('Test')
      if include_suite_setup
        suite_setup = PageCrawlerImpl.inherited_page(SuiteResponder::SUITE_SETUP_NAME, wiki_page)
        if !suite_setup.nil?
          page_path = suite_setup.page_crawler.full_path(suite_setup)
          page_path_name = PathParser.render(page_path)
          buffer.concat('!include -setup .').concat(page_path_name).concat('\n')
        end
      end
      setup = PageCrawlerImpl.inherited_page('SetUp', wiki_page)
      if !setup.nil?
        setup_path = wiki_page.page_crawler.full_path(setup)
        setup_path_name = PathParser.render(setup_path)
        buffer.concat('!include -setup .').concat(setup_path_name).concat('\n')
      end
    end
    buffer.concat(page_data.content)
    if page_data.has_attribute('Test')
      teardown = PageCrawlerImpl.inherited_page('TearDown', wiki_page)
      if !teardown.nil?
        tear_down_path = wiki_page.page_crawler.full_path(teardown)
        tear_down_path_name = PathParser.render(tear_down_path)
        buffer.concat('\n').concat('!include -teardown .').concat(tear_down_path_name).concat('\n')
      end
      if include_suite_setup
        suite_teardown = PageCrawlerImpl.inherited_page(SuiteResponder::SUITE_TEARDOWN_NAME, wiki_page)
        if !suite_teardown.nil?
          page_path = suite_teardown.page_crawler.full_path(suite_teardown)
          page_path_name = PathParser.render(page_path)
          buffer.concat('!include -teardown .').concat(page_path_name).concat('\n')
        end
      end
    end
    page_data.content = buffer
    return page_data.html
  end

end




HtmlUtil.testable_html(Page.new("", {'Test' => ''}), true)
