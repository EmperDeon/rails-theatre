class TPerformance < ApplicationRecord
    #
    # Relations
    #
    belongs_to :theatre
    belongs_to :perf, class_name: 'Performance'

    has_many :posters, foreign_key: 't_perf_id'

    #
    # Scopes
    #
    scope :by_theatre, -> (id) { where(:theatre_id => id) }

    scope :by_type, -> (id) {
        if id then
            joins(:perf).where(performances: {type_id: id});
        end }
    scope :by_name, -> (id) {
        if id then
            where(perf_id: id);
        end }
    scope :by_theatre, -> (id) {
        if id then
            where(theatre_id: id);
        end }


end
