class PathParser

  def self.render (page_path)
    return page_path
    return "SUITE_SETUP" if page_path == "SUITE_SETUP"
    return "SUITE_TEARDOWN" if page_path == "SUITE_TEARDOWN"
  end

end

