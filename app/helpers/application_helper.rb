module ApplicationHelper
  def title(str = '')
    content_for :title, str
  end

  def add_js(str)
    content_for :js, javascript_include_tag(str)
  end
  
  def site_title
    Site.locate(request.subdomains.first).short_title
  end

  def site_tagline
    Site.locate(request.subdomains.first).title
  end

  def sortable(col, title = nil)
    title ||= col.titleize
    css_class = (col == sort_col) ? "current #{sort_dir}" : nil
    dir = col == sort_col && sort_dir == "asc" ? "desc" : "asc"
    link_to title, {:sort => col, :dir => dir}, {:class => css_class}
  end

  def include_ie_css
    m = request.env['HTTP_USER_AGENT'].match /MSIE (\d)/
    return if  m.nil?
    stylesheet_link_tag 'ie_general' if m[1].to_i < 9
    stylesheet_link_tag 'ie' + m[1]
  end
end
