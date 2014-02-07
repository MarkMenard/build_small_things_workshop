class Page

  attr_reader :attributes, :wiki_page
  attr_accessor :content

  def initialize (content, attributes = {})
    @attributes = attributes
    @content = content
  end

  def has_attribute (attribute_name)
    attributes.has_key?(attribute_name)
  end

  def html
    "#{content}"
  end

  def wiki_page
    @wiki_page ||= Page.new("")
  end

  def page_crawler
    PageCrawlerImpl.new
  end
end
