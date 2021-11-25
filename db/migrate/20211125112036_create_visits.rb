class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.string :ip_address
      t.string :web_browser
      t.string :operative_system
      t.date :date
      t.references :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
