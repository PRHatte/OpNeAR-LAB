class AddExtFlowIdToFlows < ActiveRecord::Migration[5.0]
  def change
    rename_column :flows, :flow_id, :ext_flow_id
  
  end
end
