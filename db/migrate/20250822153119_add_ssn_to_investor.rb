class AddSsnToInvestor < ActiveRecord::Migration[8.0]
  def change
    add_column :investors, :ssn, :string, default: ""
    add_index :investors, :ssn
  end
end
