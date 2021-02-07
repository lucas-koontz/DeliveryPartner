# frozen_string_literal: true

class CreatePartners < ActiveRecord::Migration[6.1]
  def change
    create_table :partners, id: :uuid do |t|
      t.string :trading_name, null: false
      t.string :owner_name, null: false
      t.string :document, null: false
      t.multi_polygon :coverage_area, null: false
      t.st_point :address, null: false

      t.timestamps

      t.index :document, unique: true
    end
  end
end
