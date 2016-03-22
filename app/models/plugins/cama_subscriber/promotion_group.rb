class Plugins::CamaSubscriber::PromotionGroup < ActiveRecord::Base
  belongs_to :promotion, class_name: 'Plugins::CamaSubscriber::Promotion'
  belongs_to :group, class_name: 'Plugins::CamaSubscriber::Group'
end