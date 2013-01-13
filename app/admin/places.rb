ActiveAdmin.register Place do
  
  config.sort_order = "name_asc"

  index do
    selectable_column
    column :name  do |s| link_to s.name, admin_place_path(s) end
    column :address
    column :latitude
    column :longitude
    column :visible do |s| true end
    default_actions
    #column { |sighting| link_to('Approve', approve_admin_sighting_path(sighting), :method => :put) unless sighting.approved? }
  end

  # Show Page

  show do |s|
    attributes_table do
      row :id
      row :name
      row :address
      row :latitude
      row :longitude
      row :description
      row :photo_urls do |s| s.photo_urls.map {|u| link_to image_tag(u), u}.join(" ").html_safe end
      row :created_at
    end
    active_admin_comments
  end

   # Edit Page

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :latitude
      f.input :longitude
      f.input :description
      f.input :photo_urls, :hint => "One URL per line, please.", :input_html => { :value => f.object.photo_urls.join("\n") }
    end
    f.buttons
  end

end
