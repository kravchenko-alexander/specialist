class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.integer :device_kind,   null: false, default: 0
      t.string  :access_token,  null: false, default: nil
      t.string  :refresh_token, null: false, default: nil
      t.string  :push_token,    null: true,  default: nil
      t.uuid    :user_id,       null: false, foreign_key: true, index: true
      t.uuid    :provider_id,   null: false, foreign_key: true, index: true
      t.datetime :access_token_expiration,  null: false, default: Time.zone.now
      t.datetime :refresh_token_expiration, null: false, default: Time.zone.now
      t.timestamps null: false
    end

    add_index :sessions, [:user_id, :access_token, :provider_id], name: 'sessions_user_token'
    add_index :sessions, [:user_id, :access_token, :refresh_token], name: 'sessions_user_tokens'
    add_index :sessions, [:access_token_expiration, :access_token], name: 'sessions_access_token'
    add_index :sessions, [:refresh_token_expiration, :refresh_token], name: 'sessions_refresh_token'
  end
end
