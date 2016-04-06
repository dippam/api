module ApplicationHelper
  def title(str = '')
    content_for :title, str
  end

  def sortable(col, title = nil)
    title ||= col.titleize
    dir = col == sort_col && sort_dir == 'asc' ? 'desc' : 'asc'
    link_to title, {sort: col, dir: dir}
  end
end
