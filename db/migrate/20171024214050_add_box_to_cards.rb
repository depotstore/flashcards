# :no doc
class AddBoxToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :box, :integer, default: 0
    add_column :cards, :wrong_guess, :integer, default: 0
  end
end
