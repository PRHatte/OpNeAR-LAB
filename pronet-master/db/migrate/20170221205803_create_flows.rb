class CreateFlows < ActiveRecord::Migration[5.0]
  def change
    create_table :flows do |t|
      t.integer :flow_id
      t.string :title
      t.string :destination
      t.string :source
      t.integer :status
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :min_bandwidth
      t.decimal :max_bandwidth
      t.string :bandwidth_unit
      t.integer :latency
      t.string :method
     

      t.timestamps
    end

    add_index :flows, :flow_id, unique: true
  end
end
