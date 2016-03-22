class Plugins::CamaSubscriber::PromotionItem < ActiveRecord::Base
  belongs_to :promotion, class_name: 'Plugins::CamaSubscriber::Promotion'
  belongs_to :item, class_name: 'Plugins::CamaSubscriber::Item'
  scope :open, ->{ where.not(qty_opened: 0) }
  scope :no_open, ->{ where(qty_opened: 0) }
  # scope :open, ->{ where('last_open_at is not null') }

  def increment!
    self.update(qty_opened: self.qty_opened + 1)
  end
end