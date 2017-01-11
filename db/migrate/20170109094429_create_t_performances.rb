class CreateTPerformances < ActiveRecord::Migration[5.0]
    def change
        create_table :t_performances do |t|
            t.integer :theatre_id
            t.integer :perf_id

            t.string :img
            t.string :desc_s
            t.text :desc

            t.timestamps
        end
        add_foreign_key :t_performances, :theatres
        add_foreign_key :t_performances, :performances, column: :perf_id
    end
end
