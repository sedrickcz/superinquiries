class CreateSuperinquiriesInboxesItems < ActiveRecord::Migration
  def up
    create_table :refinery_superinquiries_inboxes_items do |t|
      t.integer :inbox_id
      t.string  :input_name
      t.string  :value
      t.timestamps
    end
  end

  def down
    drop_table :refinery_superinquiries_inboxes_items
  end
end
