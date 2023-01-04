class CreateTeasSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :teas_subscriptions do |t|
      t.references :tea, foreign_key: true
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
