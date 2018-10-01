class AddUserIdToFlows < ActiveRecord::Migration[5.0]
  def change
    add_column :flows, :user_id, :integer
  end
end
