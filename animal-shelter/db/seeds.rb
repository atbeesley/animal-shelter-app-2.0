require_relative('../models/animal')
require_relative('../models/customer')

require('pry-byebug')

Animal.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name' => 'Obi-Wan Kenobi',
  'age' => 65,
  'profession' => 'Jedi knight'
  })

customer2 = Customer.new({
  'name' => 'Princess Leia',
  'age' => 17,
  'profession' => 'diplomat'
  })

customer3 = Customer.new({
  'name' => 'Luke Skywalker',
  'age' => 17,
  'profession' => 'moisture farmer'
  })

customer4 = Customer.new({
  'name' => 'Han Solo',
  'age' => 32,
  'profession' => 'smuggler and scoundrel'
  })

customer1.save()
customer2.save()
customer3.save()
customer4.save()

animal1 = Animal.new({
  'name' => 'Theresa',
  'type' => 'tauntaun',
  'admission_date' => '23/10/2017',
  'adoptable' => true,
  'customer_id' => nil
   })

animal2 = Animal.new({
  'name' => 'Betty',
  'type' => 'bantha',
  'admission_date' => '04/07/2018',
  'adoptable' => true,
  'customer_id' => customer1.id
  })

animal3 = Animal.new({
    'name' => 'Percy',
    'type' => 'porg',
    'admission_date' => '06/06/2019',
    'adoptable' => false,
    'owner_id' => customer2.id
    })

animal4 = Animal.new({
  'name' => 'Ryan',
  'type' => 'Rancor',
  'admission_date' => '10/09/2019',
  'adoptable' => false,
  'customer_id' => customer3.id
  })

animal1.save()
animal2.save()
animal3.save()
animal4.save()


binding.pry
nil
