class Plugins::CamaSubscriber::Group < ActiveRecord::Base
  belongs_to :site, class_name: "CamleonCms::Site", foreign_key: :site_id
  has_many :item_groups, class_name: 'Plugins::CamaSubscriber::GroupItem'
  has_many :items, class_name: 'Plugins::CamaSubscriber::Item', through: :item_groups
end