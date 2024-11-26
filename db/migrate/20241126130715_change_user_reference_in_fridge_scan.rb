class ChangeUserReferenceInFridgeScan < ActiveRecord::Migration[7.1]
  def change
    remove_reference :fridge_scans, :user, foreign_key: true
    add_reference :fridge_scans, :user, foreign_key: true
  end
end
