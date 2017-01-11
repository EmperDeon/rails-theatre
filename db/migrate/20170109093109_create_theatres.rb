class CreateTheatres < ActiveRecord::Migration[5.0]
    def change
        create_table :theatres do |t|
            t.string :name
            t.text :desc
            t.string :img
            t.string :address
            t.string :tel_num

            t.timestamps
        end
    end
end
