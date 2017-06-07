module TicketsHelper
  #
  # Utility
  #
  def self.get_sectors (json, db_seats)
    sect = json['sectors'] || []
    resp = {}

    seats = db_seats.collect {|v| v[0].split('-')}
    prices = Hash[db_seats.collect {|v| [v[0], v[1]]}]

    sect.each {|sect|
      pref = sect['pref']
      rs = []
      ss = {}

      seats.select {|v| v[0] == pref}.each {|v|
        r = v[1]
        s = v[2]

        rs << r unless rs.include? r

        if ss.include? r
          ss[r] << s
        else
          ss[r] = [s]
        end
      }

      resp[pref] = {name: sect['name'], rows: rs, seats: ss}
    }

    {sectors: resp, prices: prices}
  end

  #
  # Return link to buy form, if there are seats
  #  poster:: Poster model
  def get_buy_ticket_link(poster)
    cl = 'btn btn-primary buy_link'

    if Seat.by_poster(poster).count == 0
      n = 'Цены не заданы'
      cl += ' disabled'

    elsif Seat.not_sell.by_poster(poster).count == 0
      n = 'Мест нет'
      cl += ' disabled'

    else
      n = 'Забронировать место'
    end

    link_to n, "/tickets/buy_form/#{poster.id}", class: cl, remote: true
  end
end
