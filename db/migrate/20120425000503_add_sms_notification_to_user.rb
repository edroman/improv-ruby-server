class AddSmsNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_notification, :boolean

  end
end
