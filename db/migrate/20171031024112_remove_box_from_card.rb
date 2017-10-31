class RemoveBoxFromCard < ActiveRecord::Migration[5.1]
  def change
    remove_column :cards, :box, :integer, default: 0
  end
end
