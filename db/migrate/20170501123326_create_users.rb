class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string  :email,           default: '',  null: false, unique: true
      t.string  :password_digest, default: '',  null: false
      t.string  :first_name,      default: '',  null: true
      t.string  :last_name,       default: '',  null: true
      t.date    :birthday,        default: nil, null: true
      t.integer :gender,          default: nil, null: true
      t.string  :secret_token,    default: nil, null: false
      t.timestamps null: false
    end

    add_index :users, :email
  end
end
