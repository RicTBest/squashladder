class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :date
      t.datetime :register_date
      t.datetime :confirm_date
      t.integer :winner_score
      t.integer :loser_score
      t.integer :winner_id
      t.integer :loser_id
      t.boolean :winner_confirmed, :default => false
      t.boolean :loser_confirmed, :default => false

      t.boolean :disputed, :default => false
      t.boolean :tie, :default => false

      t.timestamps
    end
  end
end
