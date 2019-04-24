# Source for seed data: https://bluebottlecoffee.com/

require 'csv'
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

options_hash = {headers: true, header_converters: :symbol, converters: :numeric}

# User creation (80 active, 20 inactive)
users = CSV.open('db/data/MOCK_DATA_users.csv', options_hash)
user_hashes = users.map { |row| row.to_h }
n = 1

users = Hash.new
user_hashes.each do |user_hash|
  user_hash[:password] = 'password'
  user_hash[:created_at] = rand(30.0..100.0).days.ago
  user_hash[:enabled] = false if n > 80

  users[n] = User.create(user_hash)
  n += 1
end

# Merchants creation (8 active, 2 inactive)
merchants = CSV.open('db/data/MOCK_DATA_merchants.csv', options_hash)
merchant_hashes = merchants.map { |row| row.to_h }
n = 1

merchants = Hash.new
merchant_hashes.each do |merchant_hash|
  merchant_hash[:password] = 'password'
  merchant_hash[:created_at] = rand(30.0..100.0).days.ago
  merchant_hash[:role] = 1
  merchant_hash[:enabled] = false if n > 8

  merchants[n] = User.create(merchant_hash)
  n += 1
end

# Admin creation - see spec/factories/user.rb
admin = create(:admin)


# Item creation
item_1 = merchants[1].items.create(
  name: "Bella Donovan",
  description: "Bella Donovan is the wool sweater of our blends—comforting, cozy, and enveloping. Our most popular blend, Bella is a variation of the archetypal Moka-Java pairing, in which a wild and jammy natural from Ethiopia finds balance with more substantive coffees from Sumatra and Peru. It stands on the darker side of things, weathers the rigors of the automatic drip machine well, and stands up to milk or cream—though it is just as elegant black.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551138310/bbbctsi1mlpdqmcudsko.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_2 = merchants[1].items.create(
  name: "Giant Steps",
  description: "Named after John Coltrane’s Giant Steps, this dense and substantial coffee is not unlike the jazz visionary's signature \"sheets of sound.\” Our darkest blend, comprising organic coffees from Uganda, Papua New Guinea, and Sumatra, is downright viscous in the cup. Just like Coltrane’s ability to cascade into high-pitched octaves with maximum control, this coffee’s inflections of stone fruit lighten without losing focus. Improvisations of milk or cream—in any proportion—shine.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551138095/iy69rfgek69st7sxp5hn.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_3 = merchants[1].items.create(
  name: "Three Africas",
  description: "Three Africas marries the radiant fruit of two coffees from Ethiopia, one washed and one natural, with the balance and authority of a washed coffee from Uganda. Each component excels on its own, but together, they traverse boundaries. No matter the brew method, this blend, which is our brightest, has good body and an approachable complexity that takes to cream well, but stands just as radiantly on its own.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551728387/rihalpo5o0mwf4w5li8u.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_4 = merchants[2].items.create(
  name: "Beta Blend",
  description: "While many of our coffee blends are noteworthy for their sturdiness, the glassy and floral Beta Blend is cut from a different cloth. What began as a collaboration between our sourcing and digital teams has evolved into a delicate counterpoint to our heftier blends that is available for online purchase exclusively.” Our darkest blend, comprising organic coffees from Uganda, Papua New Guinea, and Sumatra, is downright viscous in the cup. Just like Coltrane’s ability to cascade into high-pitched octaves with maximum control, this coffee’s inflections of stone fruit lighten without losing focus. Improvisations of milk or cream—in any proportion—shine.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551138128/f5zzuh2xchsc7xn3mqbk.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_5 = merchants[3].items.create(
  name: "17ft Ceiling Espresso",
  description: "Named for the building specs in our Mint Plaza cafe in San Francisco, this espresso blend is pure pleasure. We reverse-engineered a blue-collar Italian espresso blend (yes, Robusta!) with high-quality organic coffee to make a sturdy, crema-heavy, and unpretentious espresso. If Hayes Valley Espresso is like consuming a volume of In Search of Lost Time in liquid form, then 17ft Ceiling is like flipping through The New Yorker—edifying without being overly taxing.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1526404876/gkhxnpntcaonvebez1ys.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_6 = merchants[3].items.create(
  name: "Hayes Valley Espresso",
  description: "We developed our darkest espresso for the launch of our first brick-and-mortar in our friend Loring’s garage in Hayes Valley. Years later, it remains the standard espresso in all of our cafes. Lower-toned and minimally bright, Hayes Valley Espresso pulls a straight shot with a voluptuous tawny crema and a somewhat dangerous-looking viscosity. Milk, in any quantity, adds romance to the coffee’s brooding aspects, bringing out the inherent chocolate and adding a smooth, rounded touch.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1526404848/r01wlbcqpgdspyszxg0n.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_7 = merchants[4].items.create(
  name: "Night Light Decaf",
  description: "Decaf should never feel like a concession. In fact, we consider this coffee a reward in its own right, especially given that its adherents drink it solely for its flavor. Like its predecessor, Decaf Noir, Night Light remains a delicious fusion of coffees from Sumatra and Central America, decaffeinated with the mind-boggling and chemical-free Swiss Water Process. And like Decaf Noir, this sweet and satisfying blend proves that decaf never has to compromise flavor—our coffee team describes it as “creamy and versatile” with decadent \“malt\” undertones. As for whether or not you still need an actual night light? We’ll let you decide. But we suggest that, like this coffee, your choice is guided by beauty rather than necessity.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551728415/hhobipemkt2rxumv7im6.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_8 = merchants[4].items.create(
  name: "New Orleans Iced Kit",
  description: "New Orleans Iced Coffee is a sweet, creamy, decadent iced coffee that’s cold-brewed with roasted chicory, then cut with whole milk and organic cane sugar.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1490998767/mygt3acq2syt7wlr0lwg.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_9 = merchants[5].items.create(
  name: "Alma Viva",
  description: "Our first blend was named after Count Almaviva from Mozart’s opera The Marriage of Figaro. Inspiration sparked when our founder, James Freeman, was listening to an angelic duet between the Count’s wife, Rosina, and his paramour, Susanna. To mimic their harmonies, James roasted one coffee from Central America to two different levels before blending, a technique known as melange roasting. This time around, we’ve achieved a similar effect by combining two organic coffees from Colombia and Papua New Guinea. Though the components have changed, the blend’s transcendent harmonies still ring true.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1551982777/ocfgpkmzczswx6mpb8nz.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_10 = merchants[6].items.create(
  name: "Opascope Espresso",
  description: "What’s in a name? Well, we’ve always been fans of the opascope, a beautiful tool for projecting handwriting and finely rendered artwork onto a larger surface. We could blab for hours about its quaint design, its bulky contours, its place in our childhood classrooms. But for expediency’s sake, let’s put it this way: The opascope is a tool for taking careful craftsmanship and opening it up for everyone to access and enjoy. Sound familiar? Available only in the Bay Area and online, Opascope Espresso is a refreshing addition to a lineup once dominated by dense, chocolatey selections. It yields an effervescent shot, packed with stripes of tropicalia.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1526404899/uwboy5luvxzmrttbe3ml.jpg",
  quantity: rand(1..20),
  price: rand(10..20),
  created_at: rand(1.0..30.0).days.ago
)

item_11 = merchants[7].items.create(
  name: "Bodum Chambord 17oz French Press",
  description: "This excellent single-person French press from Bodum includes chrome feet, black bakelite plastic knob and handle, and special Bodum-designed insulated lid. This three-tasse design has better heat retention than the skinny three-tasse size.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1490999589/xzgrd3bqvysyqxykvibs.jpg",
  quantity: rand(1..20),
  price: rand(30..40),
  created_at: rand(1.0..30.0).days.ago
)

item_12 = merchants[8].items.create(
  name: "AeroPress",
  description: "Because it was conceived just 38.5 miles from our Oakland roastery by Aerobie (those wonderful folks who created an improbably long-flying disc), we'd like to humbly assert that the AeroPress is our first locally-produced piece of merchandise. It’s a peculiar and lovely device – easily the most durable and portable option for brewing quality coffee. It produces a cup that’s thick and focused, but still quite nuanced.",
  image_url: "https://blue-bottle-cms.global.ssl.fastly.net/hbhhv9rz9/image/upload/c_thumb,h_576,w_576/v1486399954/u06l7rfl6noxg1t4reim.jpg",
  quantity: rand(1..20),
  price: rand(30..40),
  created_at: rand(1.0..30.0).days.ago
)

inactive_item_1 = create(:inactive_item, user: merchants[9])
inactive_item_2 = create(:inactive_item, user: merchants[10])


# Order generation of all types
user_count = User.where(role: 0).count
item_count = Item.count

# pending order, none fulfilled
n = 1
until n == 10 do
  order = create(:order, user: users[rand(1..user_count)])

  # Generate random item ids
  random_item_id_1, random_item_id_2 = (1..item_count).to_a.sample(2)

  random_item_1 = Item.find(random_item_id_1)
  random_item_2 = Item.find(random_item_id_2)

  create(:order_item, order: order, item: random_item_1, order_price: rand(10..20), quantity: rand(1..5))
  create(:order_item, order: order, item: random_item_2, order_price: rand(10..20), quantity: rand(1..5))
  n += 1
end

# pending order, partially fulfilled
n = 1
until n == 10 do
  order = create(:order, user: users[rand(1..user_count)])

  # Generate random item ids
  random_item_id_1, random_item_id_2 = (1..item_count).to_a.sample(2)

  random_item_1 = Item.find(random_item_id_1)
  random_item_2 = Item.find(random_item_id_2)

  create(:order_item, order: order, item: random_item_1, order_price: rand(10..20), quantity: rand(1..5))
  create(:fulfilled_order_item, order: order, item: random_item_2, order_price: rand(10..20), quantity: rand(1..5))
  n += 1
end

# packaged order
n = 1
until n == 10 do
  order = create(:order, user: users[rand(1..user_count)])

  # Generate random item ids
  random_item_id_1, random_item_id_2 = (1..item_count).to_a.sample(2)

  random_item_1 = Item.find(random_item_id_1)
  random_item_2 = Item.find(random_item_id_2)

  create(:fulfilled_order_item, order: order, item: random_item_1, order_price: rand(10..20), quantity: rand(1..5))
  create(:fulfilled_order_item, order: order, item: random_item_2, order_price: rand(10..20), quantity: rand(1..5))
  n += 1
end

# shipped order, cannot be cancelled
n = 1
until n == 10 do
  order = create(:shipped_order, user: users[rand(1..user_count)])

  # Generate random item ids
  random_item_id_1, random_item_id_2 = (1..item_count).to_a.sample(2)

  random_item_1 = Item.find(random_item_id_1)
  random_item_2 = Item.find(random_item_id_2)

  create(:fulfilled_order_item, order: order, item: random_item_1, order_price: rand(10..20), quantity: rand(1..5))
  create(:fulfilled_order_item, order: order, item: random_item_2, order_price: rand(10..20), quantity: rand(1..5))
  n += 1
end

# cancelled order
n = 1
until n == 10 do
  order = create(:cancelled_order, user: users[rand(1..user_count)])

  # Generate random item ids
  random_item_id_1, random_item_id_2 = (1..item_count).to_a.sample(2)

  random_item_1 = Item.find(random_item_id_1)
  random_item_2 = Item.find(random_item_id_2)

  create(:order_item, order: order, item: random_item_1, order_price: rand(10..20), quantity: rand(1..5), created_at: (rand(23)+1).hour.ago, updated_at: rand(59).minutes.ago)
  create(:order_item, order: order, item: random_item_2, order_price: rand(10..20), quantity: rand(1..5), created_at: (rand(23)+1).hour.ago, updated_at: rand(59).minutes.ago)
  n += 1
end

# Confirmaiton messages
puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
