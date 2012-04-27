class AddTurnToSentence < ActiveRecord::Migration
  def change
    add_column :sentences, :turn, :integer

  end
end
