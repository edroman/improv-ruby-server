class ChangeSmsNotification < ActiveRecord::Migration
  def change
    remove_column :users, :sms_notification
    add_column :users, :sms_notification, :boolean, :default => true
  end
end
