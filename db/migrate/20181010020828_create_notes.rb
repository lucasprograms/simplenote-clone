class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title, index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
