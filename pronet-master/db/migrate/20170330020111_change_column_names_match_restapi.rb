class ChangeColumnNamesMatchRestapi < ActiveRecord::Migration[5.0]
  def change
    rename_column :flows, :source, :src
    rename_column :flows, :destination, :dst
    
    add_column :flows, :bw, :decimal
    add_column :flows, :duration, :decimal
    add_column :flows, :startt, :decimal

  end
end
