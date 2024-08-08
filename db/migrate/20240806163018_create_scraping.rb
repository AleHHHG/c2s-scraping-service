class CreateScraping < ActiveRecord::Migration[7.1]
  def change
    create_table :scrapings do |t|
      t.string :task_url
      t.integer :task_id
      t.string :brand
      t.string :kind
      t.decimal :price
      t.boolean :completed
      t.text :note
      t.timestamps
    end
  end
end
