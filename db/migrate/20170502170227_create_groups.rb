class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups, id: :uuid do |t|
      t.string  :name,      null: false, default: ''
      t.string  :type,      null: false, default: ''
      t.boolean :is_opened, null: false, default: false
      t.timestamps null: false
    end
  end
end
