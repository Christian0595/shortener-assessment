class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.text :url
      t.string :code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
