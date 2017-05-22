class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def self.where_time(time)
    q = "DATE_FORMAT(date, '%H:%i') = ?"

    where(q, UtilsHelper.get_hash('time')[time.to_i])
  end

  def self.where_day_of_week (day)
    q = 'DAYOFWEEK(date) = ?'

    where(q, day.to_s)
  end

  def self.where_month (month)
    q = 'MONTH(date) = ?'

    where(q, month)
  end

end
