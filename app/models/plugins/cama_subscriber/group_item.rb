class Plugins::CamaSubscriber::GroupItem < ActiveRecord::Base
  belongs_to :group, class_name: 'Plugins::CamaSubscriber::Group'
  belongs_to :item, class_name: 'Plugins::CamaSubscriber::Item'
end