class TPerformance < ApplicationRecord
    #
    # Relations
    #
    belongs_to :theatre
    belongs_to :perf, class_name: 'Performance'
    belongs_to :t_hall

    has_many :posters, foreign_key: 't_perf_id'
    has_and_belongs_to_many :actors, through: :actors_t_performances


    #
    # Scopes
    #
    scope :by_type, -> (id) { joins(:perf).where(performances: {p_type_id: id}) if id }
    scope :by_name, -> (id) { where(perf_id: id) if id }
    scope :by_theatre, -> (id) { where(theatre_id: id) if id }


    #
    # Helper methods
    #
    def self.get_setting_vals (id)
        p = self.find(id)
        type = p.perf.p_type_id
        name = p.perf_id
        theatre = p.theatre_id

        #
        r = {}
        r['type'] = type
        r['name'] = name
        r['theatre'] = theatre

        r
    end
end
