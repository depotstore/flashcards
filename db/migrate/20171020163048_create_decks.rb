class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.boolean :current, default: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
