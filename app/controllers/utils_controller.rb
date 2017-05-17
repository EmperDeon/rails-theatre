class UtilsController < ApplicationController

	def get_hall_preview
		# THall.find(params[:id]).img
		send_file get_image(params[:id], params[:poster])
	end

	def get_image(id, poster = 0)
		json = JSON.parse(THall.find(id).json)

		w = json['width'] || 0
		h = json['height'] || 0
		cs = 30

		if w == 0 || h == 0
			return 'none'
		end

		# Create
		seat_n = [] # Seat exists
		sect_s = [] # Sector color
		sect_c = [] # Sector colors
		sect_n = [] # Sector prefixes
		seat_t = [] # Seat number
		seat_r = [] # Seat row
		seats = []

		# Initialize with 0
		(w * h).times {
			seat_n << false
			sect_s << 0
			seat_t << 0
			seat_r << 0
			seats << 0
		}

		# Fill seats seat_n
		json['seats'].each { |s|
			s = s.split(':')

			x = s[0].to_i
			y = s[1].to_i

			s[2].to_i.times {
				seat_n[x + y * w] = true

				x += 1
			}
		}

		json['sectors'].each { |o|
			s_id = sect_c.size + 1

			sect_c << GD2::Color::from_s(o['color'])

			o['coords'].each { |c|
				c = c.split(':')
				sect_s[c[0].to_i + c[1].to_i * w] = s_id
				sect_n[s_id] = o['pref']
			}
		}

		sect_r = {}
		(0...h).each { |y|
			(0...w).each { |x|
				unless (t = sect_s[x + y * w]) == 0
					if sect_r.include? t
						if sect_r[t][1] >= x
							sect_r[t][0] += 1
						end

						sect_r[t][1] = x
					else
						sect_r[t] = [1, x]
					end

					seat_r[x + y * w] = sect_r[t][0]
				end
			}
		}

		json['seat_n'].each { |o|
			o = o.split(':')
			st = o[0].to_i
			x = o[1].to_i
			y = o[2].to_i
			lf = o[3].to_i == 1

			i = seat_n[x + y * w]
			curr_s = sect_s[x + y * w]

			while (x > -1 && x < w) && sect_s[x + y * w] == curr_s
				seat_t[x + y * w] = st
				st += 1

				x += lf ? -1 : 1

				if i == 0 || curr_s == 0
					break
				end
			end
		}

		# Prices
		price = {}
		json_price = JSON.parse(Poster.find(poster).price)

		json_price['prices'].each { |v|
			price[v['price']] = v['id']
		}

		seat_prices = json_price['seats']


		seat_state = ActiveRecord::Base.send(:sanitize_sql_array, ['SELECT seat FROM seats WHERE poster_id = ? AND sell = 0', poster])
		seat_state = ActiveRecord::Base.connection.execute(seat_state)
		seat_state = seat_state.collect { |v| v[0] }

		(0...h).each { |y|
			(0...w).each { |x|
				unless seat_t[x + y * w] == 0
					seat = "#{sect_n[sect_s[x + y * w]]}-#{'%02d' % seat_r[x + y * w]}-#{'%02d' % seat_t[x + y * w]}"

					if seat_state.include? seat

					else
						logger.warn "#{seat}"

					end

					seats[x + y * w] = (seat_state.include? seat) ? price[seat_prices[seat].to_s] : -1

				end
			}
		}

		price = json_price['prices'].each_with_object({}) { |v, o|
			o[v['id']] = GD2::Color::from_s(v['color'])
			o[v['id']].a = 0.55
		}
		price[-1] = GD2::Color::from_s('#88555555')

		colors = json_price['prices'].each_with_object({}) { |v, o|
			o[v['price']] = GD2::Color::from_s(v['color'])
			o[v['price']].a = 0.55
		}

		save_image draw_image(w, h, cs, seat_n, sect_s, sect_c, seat_r, seat_t, seats, price, colors)
	end

	private
	def draw_image(w, h, cs, seat_n, sect_s, sect_c, seat_r, seat_t, seats, price, colors)
		i = GD2::Image::TrueColor.new(w * cs, h * cs)
		# c = GD2::Canvas.new(i)
		i.draw { |c|

			c.color = GD2::Color.new(233, 233, 233)
			c.rectangle(0, 0, w * cs, h * cs, true)

			c.font = GD2::Font::TrueType.new('public/DejaVuSans.ttf', 8)

			(0...w).each { |x|
				(0...h).each { |y|
					# Draw seats
					c.color = GD2::Color.new(175, 175, 175)
					if seat_n[x + y * w]
						draw_rect(c, cs, x, y)
					end

					# Draw sectors
					unless (s = sect_s[x + y * w]) == 0
						c.color = sect_c[s - 1]
						draw_rect(c, cs, x, y)
					end

					# Draw price overlay
					unless (s = seats[x + y * w]) == 0
						c.color = price[s]
						draw_rect(c, cs, x, y)
					end


				}
			}

			c.color = GD2::Color.new(255, 255, 255)
			(0...w).each { |x|
				(0...h).each { |y|
					# Draw row text
					unless (r = seat_r[x + y * w]) == 0
						draw_text(c, cs, x, y, r.to_s, 2, 12)
					end

					# Draw seat text
					unless (t = seat_t[x + y * w]) == 0
						if t > 9
							draw_text(c, cs, x, y, t.to_s, 16, 28)
						else
							draw_text(c, cs, x, y, t.to_s, 22, 28)
						end
					end
				}
			}

			ox = oy = 0
			c.font = GD2::Font::TrueType.new('public/DejaVuSans.ttf', 11)

			colors.each { |price, color|
				c.color = color
				draw_rect(c, cs * 0.5, ox, oy)

				c.color = GD2::Color.new(127, 127, 127, 0)
				draw_text(c, cs * 0.5, ox, oy, " - #{price}", 14, 12)
				ox += 5
			}

		}

		i.png
	end

	def save_image (d)
		# file name for original img
		file = Digest::SHA256.hexdigest(d)
		file_n = "public/halls/#{ file }.png"

		File.open(file_n, 'wb') do |f|
			f.write(d)
		end

		# if Rails.env.production?
		# 	Cloudinary::Uploader.upload file_n + '.png', public_id: file
		# end

		File.join Rails.root, file_n
	end

	def draw_rect (c, cs, x, y, f = true)
		c.rectangle(x * cs + 1, y * cs + 1, x * cs + cs - 1, y * cs + cs - 1, f)
	end

	def draw_text (c, cs, x, y, t, ox = 0, oy = 0)
		c.move_to(x * cs + ox, y * cs + oy)
		c.text t
	end
end


class GD2::Color
	def self.from_s (s)
		s = s[1..-1]

		a = s[0..1].to_i(16)
		r = s[2..3].to_i(16)
		g = s[4..5].to_i(16)
		b = s[6..7].to_i(16)

		new(r, g, b, a)
	end
end