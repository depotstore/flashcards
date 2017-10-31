class AddRepetitionToCard < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :ef, :decimal, precision: 4, scale: 3, default: 2.5
    add_column :cards, :repetition, :integer, default: 0
    add_column :cards, :interval, :integer, default: 0
  end
end
