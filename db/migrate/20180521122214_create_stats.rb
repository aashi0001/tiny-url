class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :link_id
      t.string :platform
      t.string :ip_address

      t.timestamps
    end
  end
end
