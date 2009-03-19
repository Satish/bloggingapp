module PagesHelper

  def page_path(page, options = {})
    suffix = options[:anchor] ? "##{options[:anchor]}" : ""
    path = page.url + suffix
  end
  
end
