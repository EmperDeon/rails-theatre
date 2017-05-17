hallSectorChange = ->
  rows = $('#hallRows')
  rows.empty()

  create_options_for(get_rows(), rows)


hallRowChange = ->
  seats = $('#hallSeats')

  # Store current seat
  curr_seat = seats.val()

  # Clear
  seats.empty()

  create_options_for(get_seats(), seats)

  # Set seat to previous value
  $("#hallSeats option[value='#{curr_seat}']").prop('selected', true)

hallSeatChange = ->
  seat = get_current_seat()
  $('#hallPrice').html(hall_prices[seat])


tryBuyTicket = ->
  bt = $('#hallBuy')
  a = bt.prop('href')
  a = a.substr(0, a.lastIndexOf('/') + 1)
  bt.prop('href', a + get_current_seat())

get_seats = ->
  c_s = $('#hallSectors').val()
  c_r = $('#hallRows').val()

  hall_seats[c_s].seats[c_r]


get_rows = ->
  curr = $('#hallSectors').val()
  h = hall_seats[curr].seats

  ks = []
  $.each(h, (k, v) ->
    ks.push k
  )

  ks.sort()


get_current_seat = ->
  c_sc = $('#hallSectors').val()
  c_rw = $('#hallRows').val()
  c_st = $('#hallSeats').val()

  [c_sc, c_rw, c_st].join('-')


create_options_for = (mas, obj, call = (k, v) -> {text: v, value: v}) ->
  $.each(mas, (k, v) ->
    $('<option />', call(k, v)).appendTo(obj);
  )


hall_reinit = ->
  sc = $('#hallSectors')
  rw = $('#hallRows')
  st = $('#hallSeats')
  bt = $('#hallBuy')

  sc.change(hallSectorChange)
  rw.change(hallRowChange)
  rw.change(hallSeatChange)
  st.change(hallSeatChange)
  bt.click(tryBuyTicket)

  sc.trigger('change')
  rw.trigger('change')
  st.trigger('change')


window.hall_reinit = hall_reinit
window.create_options_for = create_options_for
window.get_current_seat = get_current_seat