module ApplicationHelper

  def image_url(source)
    URI.join(root_url, image_path(source))
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''

    html = content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end

    html += content_tag(:li, :class => "divider-vertical") {}
  end

end
