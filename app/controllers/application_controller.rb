class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_admin_locale

  private

  def set_admin_locale
    if request[:controller] =~ /^(active_admin|admin)\//
      I18n.locale = :en
    else
      I18n.locale = 'pt-PT'
    end
  end
end
