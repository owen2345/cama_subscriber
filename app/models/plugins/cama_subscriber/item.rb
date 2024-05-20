class Plugins::CamaSubscriber::Item < ActiveRecord::Base
  STATUS = ['approved', 'pending', 'unsubscribed']
  include CamaleonCms::Metas
  belongs_to :site, class_name: "CamaleonCms::Site", foreign_key: :site_id
  has_many :item_groups, class_name: 'Plugins::CamaSubscriber::GroupItem'
  has_many :groups, class_name: 'Plugins::CamaSubscriber::Group', through: :item_groups
  before_save :check_unsubscribed_status

  scope :active, ->{ where(status: 'approved') }
  scope :pending, ->{ where(status: 'pending') }
  scope :unsubscribed, ->{ where(status: 'unsubscribed') }

  # values: (Hash)
  # sample: {company: 'camaleon cms', city: 'Cochabamba'}
  def extra_values(values)
    self.set_multiple_options(values, 'custom_values')
  end

  # add this item into groups
  def add_groups(group_ids = [])
    g = self.groups.pluck(:id)
    self.item_groups.where(group_id: g - group_ids).destroy_all
    (group_ids - g).each do |g_id|
      self.item_groups.create(group_id: g_id)
    end
  end

  # unsubscribe user from all groups
  def unsubscribe!
    self.update(status: 'unsubscribed')
  end

  private
  def check_unsubscribed_status
    if self.status_changed?
      if self.status == 'unsubscribed'
        self.unsubscribed_at = Time.current
      else
        self.unsubscribed_at = nil
      end
    end
  end
end
