class CreateSuperinquiriesInboxes < ActiveRecord::Migration
  def up
    create_table :refinery_superinquiries_inboxes do |t|
      t.integer :superinquiry_id
      t.integer :checked, default: false
      t.boolean :spam, default: false

      t.timestamps
    end
  end

  def down
    drop_table :refinery_superinquiries_inboxes
  end
end
