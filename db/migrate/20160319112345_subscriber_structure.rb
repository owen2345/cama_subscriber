class SubscriberStructure < ActiveRecord::Migration[4.2]
  def change
    create_table :plugins_subscriber_groups do |t|
      t.string :name
      t.string :key

      t.boolean :send_welcome
      t.string :welcome_subject
      t.text :welcome_msg

      t.boolean :send_left_group
      t.string :left_subject
      t.text :left_msg

      t.belongs_to :site, index: true
      t.timestamps
    end

    create_table :plugins_subscriber_group_items do |t|
      t.belongs_to :group, index: true
      t.belongs_to :item, index: true
      t.string :status, default: 'active'
      t.timestamps
    end

    create_table :plugins_subscriber_promotions do |t|
      t.string :name
      t.string :key
      t.string :layout
      t.string :template

      t.string :email_from
      t.string :email_cc
      t.string :subject
      t.text :content

      t.string :status, default: 'pending' # pending / sent

      t.belongs_to :site, index: true
      t.timestamps
    end

    create_table :plugins_subscriber_promotion_items do |t|
      t.belongs_to :promotion, index: true
      t.belongs_to :item, index: true
      t.integer :qty_opened, default: 0
      t.string :status, default: 'pending'
      t.timestamps
    end

    create_table :plugins_subscriber_promotion_groups do |t|
      t.belongs_to :promotion, index: true
      t.belongs_to :group, index: true
    end

    create_table :plugins_subscriber_items do |t|
      t.string :name
      t.string :email
      t.string :status, default: 'approved'
      t.datetime :unsubscribed_at
      t.belongs_to :site, index: true
      t.timestamps
    end
  end
end
