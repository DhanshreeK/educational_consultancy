class AddColumnToBulkSmsSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :bulk_sms_settings, :student_id, :integer
  end
end
