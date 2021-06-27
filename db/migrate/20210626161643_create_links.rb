class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.belongs_to :user
      t.string :original_url
      t.string :slug

      t.timestamps
    end
  end
end
