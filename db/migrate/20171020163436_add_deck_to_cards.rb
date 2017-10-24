class AddDeckToCards < ActiveRecord::Migration[5.1]
  def change
    add_reference :cards, :deck, foreign_key: true
  end
end
