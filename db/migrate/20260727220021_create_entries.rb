class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :slug
      t.references :category, null: false, foreign_key: true
      t.string :subtype
      t.string :level, null: false, default: "basico"
      t.string :kind, null: false, default: "animated"
      t.text :intuition
      t.string :complexity
      t.string :viz
      t.text :body
      t.text :code_snippets

      t.timestamps
    end
    add_index :entries, [ :category_id, :slug ], unique: true
  end
end
