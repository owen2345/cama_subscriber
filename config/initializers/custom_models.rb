CamaleonCms::Site.class_eval do
  has_many :subscriber_groups, class_name: "Plugins::CamaSubscriber::Group", foreign_key: :site_id
  has_many :subscriber_items, class_name: "Plugins::CamaSubscriber::Item", foreign_key: :site_id
  has_many :subscriber_promotions, class_name: "Plugins::CamaSubscriber::Promotion", foreign_key: :site_id
end