class CreateAPIGroupSubscriptions < ActiveRecord::Migration
  def change
    create_table :api_group_subscriptions do |t|
      t.references :group, index: true
      t.string :path
      t.string :tag

      t.timestamps
    end
  end
end
