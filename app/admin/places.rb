ActiveAdmin.register Place do
  
  config.sort_order = "name_asc"

  index do
    selectable_column
    column :name  do |s| link_to s.name, admin_place_path(s) end
    column :address
    column :latitude
    column :longitude
    column :visible
    default_actions
    #column { |sighting| link_to('Approve', approve_admin_sighting_path(sighting), :method => :put) unless sighting.approved? }
  end

  # Show Page

  show do |s|
    attributes_table do
      row :id
      row :name
      row :visible
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
      f.input :visible
    end
    f.buttons
  end

  config.clear_action_items!

  action_item :only => :show do
    unless place.visible?
      link_to('Display on Homepage', approve_admin_place_path(place, :next => admin_place_path(place)), :method => :put)
    else
      link_to('Remove from Homepage', deapprove_admin_place_path(place, :next => admin_place_path(place)), :method => :put)
    end
  end

  action_item :only => [:show] do
    if controller.action_methods.include?('edit')
      link_to(I18n.t('active_admin.edit_model', :model => active_admin_config.resource_name), edit_resource_path(resource))
    end
  end

  action_item :only => :show do
    if controller.action_methods.include?('destroy')
      link_to(I18n.t('active_admin.delete_model', :model => 'Place'), resource_path(resource),
        :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'))
    end
  end

  # Custom Actions

  member_action :approve, :method => :put do
    place = Place.find(params[:id])
    place.update_attribute(:visible, true)
    unless params[:next]
      redirect_to collection_path, :notice => "Place displayed on the Homepage."
    else
      redirect_to params[:next], :notice => "Place displayed on the Homepage."
    end
  end

  member_action :deapprove, :method => :put do
    place = Place.find(params[:id])
    place.update_attribute(:visible, false)
    unless params[:next]
      redirect_to collection_path, :notice => "Place hidden from the Homepage."
    else
      redirect_to params[:next], :notice => "Place hidden from the Homepage."
    end
  end

end