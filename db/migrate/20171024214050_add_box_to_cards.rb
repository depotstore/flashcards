# :no doc
class AddBoxToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :box, :integer
    add_column :cards, :wrong_guess, :integer
  end
end
