class CreateOtpVerifications < ActiveRecord::Migration[5.1]
  def change
    create_table :otp_verifications do |t|
      t.string :code
      t.string :contact_no
      t.string :otp_secret_key

      t.timestamps
    end
  end
end
