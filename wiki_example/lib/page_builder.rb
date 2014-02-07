class PageBuilder

  attr_accessor :buffer, :page_data, :include_suite_setup, :wiki_page

  def self.build_pseudo_markup (page_data, include_suite_setup)
    self.new(page_data, include_suite_setup).build_pseudo_markup
  end

  def initialize (page_data, include_suite_setup)
    @buffer = ""
    @page_data = page_data
    @include_suite_setup = include_suite_setup
    @wiki_page = page_data.wiki_page
  end

  def build_pseudo_markup
    build_setup
    include_page_content
    build_teardown
    return buffer
  end

  private

  def build_setup
    if page_data.has_attribute('Test')
      if include_suite_setup
        suite_setup = PageCrawlerImpl.inherited_page(SuiteResponder::SUITE_SETUP_NAME, wiki_page)
        if suite_setup
          page_path = suite_setup.page_crawler.full_path(suite_setup)
          page_path_name = PathParser.render(page_path)
          buffer.concat('!include -setup .').concat(page_path_name).concat("\n")
        end
      end
      setup = PageCrawlerImpl.inherited_page('SetUp', wiki_page)
      if !setup.nil?
        setup_path = wiki_page.page_crawler.full_path(setup)
        setup_path_name = PathParser.render(setup_path)
        buffer.concat('!include -setup .').concat(setup_path_name).concat("\n")
      end
    end
  end

  def include_page_content
    buffer.concat(page_data.content)
  end

  def build_teardown
    if page_data.has_attribute('Test')
      teardown = PageCrawlerImpl.inherited_page('TearDown', wiki_page)
      if !teardown.nil?
        tear_down_path = wiki_page.page_crawler.full_path(teardown)
        tear_down_path_name = PathParser.render(tear_down_path)
        buffer.concat("\n").concat('!include -teardown .').concat(tear_down_path_name).concat("\n")
      end
      if include_suite_setup
        suite_teardown = PageCrawlerImpl.inherited_page(SuiteResponder::SUITE_TEARDOWN_NAME, wiki_page)
        if !suite_teardown.nil?
          page_path = suite_teardown.page_crawler.full_path(suite_teardown)
          page_path_name = PathParser.render(page_path)
          buffer.concat('!include -teardown .').concat(page_path_name).concat("\n")
        end
      end
    end
  end

end
