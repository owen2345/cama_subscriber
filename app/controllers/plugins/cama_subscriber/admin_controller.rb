class Plugins::CamaSubscriber::AdminController < CamaleonCms::Apps::PluginsAdminController
  include Plugins::CamaSubscriber::MainHelper
  add_breadcrumb(I18n.t("plugins.cama_subscriber.title"), default: 'Newsletters')
  def settings
    add_breadcrumb(t(".settings", default: 'Settings'))
  end

  def save_settings
    @plugin.set_multiple_options(params[:settings])
    flash[:notice] = t('.saved_settings', default: 'Settings saved')
    redirect_to action: :settings
  end
end
