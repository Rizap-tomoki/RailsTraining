module BreadcrumbsHelper
    def breadcrumbs
      @breadcrumbs ||= []
    end
  
    def add_breadcrumb(name, url = '')
      breadcrumbs << { name: name, url: url }
    end
  
    def render_breadcrumbs
      return '' if breadcrumbs.empty?
  
      content_tag(:nav, aria: { label: 'breadcrumb' }) do
        content_tag(:ol, class: 'breadcrumb') do
          breadcrumbs.map do |breadcrumb|
            content_tag(:a, class: 'breadcrumb-item') do
              link_to(breadcrumb[:name], breadcrumb[:url])
            end
          end.join(' -> ').html_safe
        end
      end
    end
end