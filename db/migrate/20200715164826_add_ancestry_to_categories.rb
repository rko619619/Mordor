class AddAncestryToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :ancestry, :string
  end
end
