require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/animal')
require_relative('../models/customer')

get '/customers' do
  @customers = Customer.all
  erb(:'customers/index')
end

get '/customers/new' do
  @customers = Customer.all
  erb(:'customers/new')
end

post '/customers' do
  Customer.new(params).save
  redirect to '/customers'
end

get '/customers/:id' do
  @customer = Customer.find(params['id'])
  @animals = Animal.all()
  erb(:'customers/show')
end

get '/customers/:id/edit' do
  @animal = Animal.all
  @customer = Customer.find(params['id'])
  erb(:'customers/edit')
end

post '/customers/:id' do
  customer = Customer.new(params)
  customer.update
  redirect to "/customers/#{params['id']}"
end

post '/customers/:id/delete' do
  customer = Customer.find(params[:id])
  customer.delete
  redirect to '/customers'
end


post '/customers/:id/adopt' do
  animal = Animal.find(params["animal_id"])
  animal.customer_id = params["id"]
  animal.update()
  redirect to '/customers'
end
