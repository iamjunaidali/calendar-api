class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_notification

      t.timestamps
    end
  end
end
