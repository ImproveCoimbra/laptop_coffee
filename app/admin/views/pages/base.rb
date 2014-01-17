module ActiveAdmin
  module Views
    module Pages
      class Base < Arbre::HTML::Document
        private

        def build_active_admin_head
          within @head do
            insert_tag Arbre::HTML::Title, [title, render_or_call_method_or_proc_on(self, active_admin_application.site_title)].join(" | ")
            active_admin_application.stylesheets.each do |style, options|
              text_node stylesheet_link_tag(style, options).html_safe
            end

            # Inject script with DOM definitions
            script :type => 'text/javascript' do
              "
              var FS_CONFIG = {};
              FS_CONFIG['FOURSQUARE_CLIENT_ID'] = '#{ENV['FOURSQUARE_CLIENT_ID']}';
              FS_CONFIG['FOURSQUARE_CLIENT_SECRET'] = '#{ENV['FOURSQUARE_CLIENT_SECRET']}';
              ".html_safe
            end

            active_admin_application.javascripts.each do |path|
              text_node(javascript_include_tag(path))
            end

            if active_admin_application.favicon
              text_node(favicon_link_tag(active_admin_application.favicon))
            end

            text_node csrf_meta_tag
          end
        end

      end
    end
  end
end
