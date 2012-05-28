class AddFeedbackToSentence < ActiveRecord::Migration
  def change
    add_column :sentences, :feedback, :integer

  end
end
