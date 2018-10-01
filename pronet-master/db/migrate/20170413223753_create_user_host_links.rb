class CreateUserHostLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_host_links do |t|
      t.integer :user_id
      t.integer :host_id

      t.timestamps
    end

    add_index :user_host_links, [:host_id, :user_id]
  end
end
