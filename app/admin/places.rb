# encoding: UTF-8

ActiveAdmin.register Place do
  permit_params :address, :description, :name, :photo_urls, :latitude, :longitude, :gmap, :visible, :info_url, :sticker

  config.sort_order = "name_asc"

  index do
    selectable_column
    column :name, :sortable => :name do |s| link_to s.name, admin_place_path(s) end
    column :address
    #column :latitude
    #column :longitude
    #column 'URL' do |s| link_to "Info»", s.info_url, :title => s.info_url, :target => '_blank' if s.info_url? end
    column :sticker
    column :'Homepage?', :sortable => :visible do |s| s.visible end
    default_actions
    #column { |sighting| link_to('Approve', approve_admin_sighting_path(sighting), :method => :put) unless sighting.approved? }
  end

  # Show Page

  show do |s|
    attributes_table do
      row :id
      row :name
      row :'Displayed on Homepage?' do s.visible end
      row :sticker
      row :address
      row :computed_location do |s| render "map", { :markers => s.to_gmaps4rails }; end
      row :latitude
      row :longitude
      row :info_url do link_to s.info_url, s.info_url, :target => '_blank' if s.info_url? end
      row :description
      row :photo_urls do |s| s.photo_urls.map {|u| link_to image_tag(u), u}.join(" ").html_safe end
      row :created_at
    end
    active_admin_comments
  end

  # Edit Page

  form do |f|
    f.inputs do
      f.input :foursquare_venue, :label => 'Foursquare Venue Search'
    end
    f.inputs do
      f.input :name
      f.input :address
      f.input :latitude,   :as => :string
      f.input :longitude,  :as => :string
      f.input :info_url,   :as => :url
      f.input :sticker,    :as => :select, :collection => (2013..Time.now.year)
      f.input :description
      f.input :photo_urls, :hint => "One URL per line, please.", :input_html => { :value => f.object.photo_urls.try(:join, "\n") }
      f.input :visible
    end
    f.actions
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

  action_item :except => [:new, :show] do
    if controller.action_methods.include?('new')
      link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_name), new_resource_path)
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

  # Filters

  filter :visible,    :as => :select
  filter :sticker_eq, :as => :select, :collection => proc { ['None'] + (2013..Time.now.year).to_a }
  filter :name
  filter :info_url
  filter :description
  filter :photo_urls
  filter :created_at
  filter :updated_at

end
