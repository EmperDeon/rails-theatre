class Poster < ApplicationRecord
    #
    # Relations
    #
    belongs_to :t_perf, class_name: 'TPerformance'
    belongs_to :t_hall

    has_many :posters

    #
    # Scopes
    # TODO: Rewrite without 'then'
    scope :closest, -> (count) { order(id: :desc).limit(count).includes(:t_hall, :t_perf) } # For index

    scope :by_month, -> (month) {
        if month then
            where('MONTH(date) = ?', month);
        end }
    scope :by_day, -> (day) {
        if day then
            where('DAYOFWEEK(date) = ?', day);
        end }
    scope :by_time, -> (time) {
        if time then
            where('DATE_FORMAT(date, \'%H:%i\') = ?', get_time_arr[time.to_i-2]);
        end }

    scope :by_type, -> (id) {
        if id then
            where(t_perf_id: TPerformance::by_type(id));
        end }
    scope :by_name, -> (id) {
        if id then
            where(t_perf_id: TPerformance::by_name(id));
        end }
    scope :by_theatre, -> (id) {
        if id then
            where(t_perf_id: TPerformance::by_theatre(id));
        end }


    #
    # Helper functions
    # TODO: Maybe move to another file
    def self.get_time_arr
        ActiveRecord::Base.connection.execute(
            'SELECT DISTINCT DATE_FORMAT(date, \'%H:%i\') AS \'time\' FROM posters'
        ).to_a
    end
end
