require_relative('../db/sql_runner')
require_relative('animal')


class Customer

attr_accessor :name, :age, :profession, :id, :customer_id

def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @age = options['age']
    @profession = options['profession']
end

def save()
  sql = "INSERT INTO customers
  (
    name,
    age,
    profession
  )
  VALUES
  (
    $1, $2, $3
  )
  RETURNING *"
  values = [@name , @age, @profession]
  result = SqlRunner.run(sql, values)
  id = result.first["id"]
  @id = id.to_i
end

def self.all()
  sql = "SELECT * FROM customers"
  results = SqlRunner.run( sql )
  return results.map { |customer| Customer.new( customer ) }
end

def self.find(id)
  sql = "SELECT * FROM customers
  WHERE id = $1"
  values = [id]
  customer = SqlRunner.run(sql, values).first
  result = Customer.new(customer)
  return result
end

def delete()
  sql = "DELETE FROM customers
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def animals
  sql = "SELECT * FROM animals
  WHERE customer_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map {|animal| Animal.new(animal)}
end

def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end


end
