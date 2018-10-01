class ChangeOpticalCards < ActiveRecord::Migration[5.0]
  def change

    # Note: This is corrected by the orchestrator

    # remove_column :optical_cards, :EDFA_FLAG
    # add_column :optical_cards, :edfa_flag, :integer
  end
end
