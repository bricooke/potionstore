class ChangeCouponCreationTimeToCreatedAt < ActiveRecord::Migration
  def self.up
    rename_column :coupons, :creation_time, :created_at
  end

  def self.down
    rename_column :coupons, :created_at, :creation_time
  end
end
