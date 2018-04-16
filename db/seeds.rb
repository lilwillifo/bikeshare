# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('./db/fixture/stations.csv', headers: true, header_converters: :symbol) do |station|
  station.delete(:lat)
  station.delete(:long)
  station[:installation_date] = Date.strptime(station[:installation_date], '%m/%d/%Y')
  Station.create!(station.to_h)
end

CSV.foreach('./db/fixture/weather.csv', headers: true, header_converters: :symbol) do |weather|
  condition = {
    date: Date.strptime(weather[:date], '%m/%d/%Y'),
    max_temperature: weather[:max_temperature_f],
    min_temperature: weather[:min_temperature_f],
    mean_temperature: weather[:mean_temperature_f],
    mean_humidity: weather[:mean_humidity],
    mean_visibility: weather[:mean_visibility_miles],
    mean_wind_speed: weather[:mean_wind_speed_mph],
    precipitation: weather[:precipitation_inches],
    zipcode: weather[:zip_code]
  }

  Condition.create!(condition)
end

CSV.foreach('./db/fixture/trip.csv', headers: true, header_converters: :symbol) do |trip|
  trip.delete(:start_station_name)
  trip.delete(:end_station_name)
  trip[:condition_id] = if Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y'), zipcode: trip[:zip_code]).nil?
                          nil
                        else
                          Condition.find_by(date: Date.strptime(trip[:end_date], '%m/%d/%Y'), zipcode: trip[:zip_code]).id
                        end
  trip[:start_date] = Time.strptime(trip[:start_date], '%m/%d/%Y %H:%M')
  trip[:end_date] = Time.strptime(trip[:end_date], '%m/%d/%Y %H:%M')

  Trip.create!(trip.to_h)
end


fluffy = User.create!(username: 'fluffy', password: 'admin', first_name: 'Chuck', last_name: 'Supermutt', address: '123 Ians Street Denver, CO 80218', role: 'admin')
thrasher = User.create!(username: 'thrasher', password: 'user', first_name: 'Thrash', last_name: 'Er', address: '124 Ians Street Denver, CO 80218')
lilwillifo = User.create!(username: 'lilwillifo', password: 'user', first_name: 'Margaret', last_name: 'Williford', address: '456 Fake Street Denver, CO 80218')
bestmodever = User.create!(username: 'BestModEver', password: 'user', first_name: 'Greatest', last_name: 'Ever', address: '1331 17th St ll100, Denver, CO 80202')

order_1 = thrasher.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Ordered', total: 70)
order_2 = thrasher.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Paid', total: 20)
order_3 = lilwillifo.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Cancelled', total: 36)
order_4 = lilwillifo.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Completed', total: 18)
order_5 = lilwillifo.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Paid', total: 55)
order_6 = bestmodever.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Ordered', total: 124)
order_7 = bestmodever.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Ordered', total: 65)
order_8 = bestmodever.orders.create!(created_at: Time.now, updated_at: Time.now, status: 'Completed', total: 60)

accessory_1 = Accessory.create!(title: 'bike lock', description: 'locks things', price: 70, image: 'https://cdn.shopify.com/s/files/1/0151/2509/products/lock_3_4_view_2048x.jpeg?v=1467043766')
accessory_2 = Accessory.create!(title: 'front light', description: 'lights things', price: 20, image: 'https://images-na.ssl-images-amazon.com/images/I/61lhO98WvZL._SY355_.jpg')
accessory_3 = Accessory.create!(title: 'back light', description: 'lights things', price: 40, image: 'http://www.wigglestatic.com/product-media/5360097627/Cateye-OMNI-5-Rear-Bike-Rear-Lights-AW14-CA475TL155.jpg?w=1100&h=1100&a=7')
accessory_4 = Accessory.create!(title: 'water bottle', description: 'bottles water', price: 12, image: 'https://trek.scene7.com/is/image/TrekBicycleProducts/21706_A_1_Trek_Polar_Insulated_WaterBottle?wid=1360&hei=1020&fmt=pjpeg&qlt=40,1&iccEmbed=0&cache=on,on')
accessory_5 = Accessory.create!(title: 'gloves', description: 'warms hands', price: 35, image: 'https://images-na.ssl-images-amazon.com/images/I/51N9BKuWF5L.jpg')
accessory_6 = Accessory.create!(title: 'kickstand', description: 'holds a bike up', price: 18, image: 'https://images-na.ssl-images-amazon.com/images/I/81wN6Jg-zDL._SY355_.jpg')
accessory_7 = Accessory.create!(title: 'training wheels', description: 'kidz can ride', price: 10, image: 'http://www.livingwellaware.com/wp-content/uploads/2017/12/Training-Wheels-Work.jpg')
accessory_8 = Accessory.create!(title: 'a thing', description: 'does something', price: 100, image: 'https://thumbs.dreamstime.com/b/senior-man-shrugging-his-shoulders-8775727.jpg')
accessory_9 = Accessory.create!(title: 'seat bag', description: 'holds things', price: 24, image: 'https://images-na.ssl-images-amazon.com/images/I/91Z%2B6wK99kL._SY355_.jpg')
accessory_10 = Accessory.create!(title: 'rear rack', description: 'holds things', price: 55, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW8NLwT5gpj47ZkZViWLQQ3G1uVFZJ7m6RvFTY1TMMd63USfAy')
accessory_11 = Accessory.create!(title: 'basket', description: 'holds toto', price: 45, image: 'https://cdn.shopify.com/s/files/1/0726/1125/products/wicker_bicycle_basket_in_toasted_oat_on_bike-item000211_fdaed279-0d4e-468e-8d59-7b04ad57e3ec.jpeg?v=1478279077')
accessory_12 = Accessory.create!(title: 'spandex', description: 'emphasizes flaws', price: 90, image: 'http://static.shoplightspeed.com/shops/607940/files/001601773/sportees-sportees-athletic-fit-cycling-spandex-sho.jpg')
accessory_13 = Accessory.create!(title: 'pedals', description: 'rotates things', price: 88, image: 'https://images-na.ssl-images-amazon.com/images/I/71kOxxlcWyL._SL1500_.jpg')
accessory_14 = Accessory.create!(title: 'old bike lock', description: 'locked things', price: 10, role: 1, image: 'https://cdn3.volusion.com/euhfr.xvuyx/v/vspfiles/photos/GH2-1-3-8114D-2.jpg')

OrderAccessory.create!(order_id: order_1.id, accessory_id: accessory_1.id, quantity: 1)
OrderAccessory.create!(order_id: order_2.id, accessory_id: accessory_7.id, quantity: 2)
OrderAccessory.create!(order_id: order_3.id, accessory_id: accessory_6.id, quantity: 2)
OrderAccessory.create!(order_id: order_4.id, accessory_id: accessory_6.id, quantity: 1)
OrderAccessory.create!(order_id: order_5.id, accessory_id: accessory_11.id, quantity: 1)
OrderAccessory.create!(order_id: order_5.id, accessory_id: accessory_7.id, quantity: 1)
OrderAccessory.create!(order_id: order_6.id, accessory_id: accessory_8.id, quantity: 1)
OrderAccessory.create!(order_id: order_6.id, accessory_id: accessory_9.id, quantity: 1)
OrderAccessory.create!(order_id: order_7.id, accessory_id: accessory_11.id, quantity: 1)
OrderAccessory.create!(order_id: order_7.id, accessory_id: accessory_2.id, quantity: 1)
OrderAccessory.create!(order_id: order_8.id, accessory_id: accessory_7.id, quantity: 6)
