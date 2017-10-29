class AddLanguageToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :language, :string, default: 'en'
  end
end
