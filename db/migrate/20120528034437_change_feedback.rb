class ChangeFeedback < ActiveRecord::Migration
  def change
    remove_column :sentences, :feedback
    add_column :sentences, :feedback, :string
  end
end
