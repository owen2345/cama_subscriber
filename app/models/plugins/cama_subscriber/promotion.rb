class Plugins::CamaSubscriber::Promotion < ActiveRecord::Base
  belongs_to :site, class_name: "CamleonCms::Site", foreign_key: :site_id
  has_many :promotion_groups, class_name: 'Plugins::CamaSubscriber::PromotionGroup'
  has_many :groups, class_name: 'Plugins::CamaSubscriber::Group', through: :promotion_groups
  has_many :items, class_name: 'Plugins::CamaSubscriber::Item', through: :groups

  has_many :sent_promo_items, class_name: 'Plugins::CamaSubscriber::PromotionItem'
  has_many :sent_items, class_name: 'Plugins::CamaSubscriber::Item', through: :sent_promo_items, source: :item

  # add this item into groups
  def add_groups(group_ids = [])
    g = self.groups.pluck(:id)
    self.promotion_groups.where(group_id: g - group_ids).destroy_all
    (group_ids - g).each do |g_id|
      self.promotion_groups.create(group_id: g_id)
    end
  end

  # boolean sent or pending campaign
  def sent?
    self.status == 'sent'
  end

  def sent!
    self.update(status: 'sent')
  end
end