module Plugins::CamaSubscriber::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def cama_subscriber_on_active(plugin)
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def cama_subscriber_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def cama_subscriber_on_upgrade(plugin)
  end

  def cama_subscriber_plugin_options(args)
    # args[:links] << link_to(t('plugins.cama_subscriber.settings', default: 'Settings'), admin_plugins_cama_subscriber_settings_url).to_s
  end

  def cama_subscriber_before_admin
    items = []
    items << {icon: "group", title: t('plugins.cama_subscriber.items.title', default: 'Subscribers'), url: admin_plugins_cama_subscriber_items_path}
    items << {icon: "object-ungroup", title: t('plugins.cama_subscriber.groups.title', default: 'Groups'), url: admin_plugins_cama_subscriber_groups_path}
    items << {icon: "newspaper-o", title: t('plugins.cama_subscriber.promotions.title', default: 'Campaigns'), url: admin_plugins_cama_subscriber_promotions_path}
    items << {icon: "gear", title: t('plugins.cama_subscriber.settings', default: 'Settings'), url: admin_plugins_cama_subscriber_settings_url}
    admin_menu_insert_menu_before('settings', 'plugin_subscriber', {icon: "envelope-o", title: t('plugins.cama_subscriber.title', default: 'Subscriptions'), url: '', items: items})
  end
end
