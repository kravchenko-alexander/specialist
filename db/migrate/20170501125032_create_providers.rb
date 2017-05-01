class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers, id: :uuid do |t|
      t.string :type,    null: false, default: ''
      t.string :token,   null: false, default: ''
      t.uuid   :user_id, null: false, foreign_key: true, index: true
      t.timestamps null: false
    end

    add_index :providers, [:type, :token, :user_id], name: 'providers_user_token_type'
  end
end
