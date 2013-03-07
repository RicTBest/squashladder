class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :start_t
      t.datetime :end_t
      t.integer :user_id

      t.timestamps
    end
  end
end
