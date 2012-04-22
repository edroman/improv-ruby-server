class CreateIntros < ActiveRecord::Migration
  def change
    create_table :intros do |t|
      t.string :name

      t.timestamps
    end
  end
end
