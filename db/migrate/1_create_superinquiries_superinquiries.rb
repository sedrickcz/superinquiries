class CreateSuperinquiriesSuperinquiries < ActiveRecord::Migration

  def up
    create_table :refinery_superinquiries do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-superinquiries"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/superinquiries/superinquiries"})
    end

    drop_table :refinery_superinquiries

  end

end
