class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.uuid   :user_id,  null: false, foreign_key: true, index: true
      t.uuid   :group_id, null: false, foreign_key: true, index: true
      t.boolean :is_with_access, null: false, default: false
      t.string  :type,           null: false, default: ''
    end
  end
end
