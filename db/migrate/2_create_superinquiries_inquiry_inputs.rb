class CreateSuperinquiriesInquiryInputs < ActiveRecord::Migration
  def up
    create_table :refinery_superinquiries_inquiry_inputs do |t|
      t.integer :superinquiry_id
      t.string :superform_id
      t.boolean :required, default: false

      t.timestamps
    end
  end

  def down
    drop_table :refinery_superinquiries_inquiry_inputs
  end
end
