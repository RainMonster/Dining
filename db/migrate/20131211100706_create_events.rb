class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true
      t.integer    :number_of_seats, default: 8
      t.string     :neighborhood
      t.string     :picture_of_dish
      t.string     :region
      t.string     :restaurant_name
      t.text       :description
      t.datetime   :RSVP_deadline
      t.datetime   :event_time

      t.timestamps
    end
  end
end
