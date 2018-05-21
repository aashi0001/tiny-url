class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :original_url
      t.string :short_url
      t.string :censor_url
      t.integer :clicks, default: 0
      t.string  :geo_location
      t.string  :platform

      t.timestamps
    end
  end
end
