require_relative('../db/sql_runner')
require_relative('customer')

class Animal

  attr_accessor(:name, :type, :admission_date, :adoptable, :customer_id, :id)

  def initialize( options )
    @name = options['name']
    @type = options['type']
    @admission_date = options['admission_date']
    @adoptable = options['adoptable']
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i if options['customer_id']
  end

  def save()
    sql = "INSERT INTO animals
    (
      name,
      type,
      admission_date,
      adoptable,
      customer_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING *"
    values = [@name, @type, @admission_date, @adoptable, @customer_id]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def update()
    sql = "UPDATE animals
    SET (
      name,
      type,
      admission_date,
      adoptable,
      customer_id
      ) = (
        $1, $2, $3, $4, $5
      )
      WHERE id = $6"
      values = [@name, @type, @admission_date, @adoptable,  @customer_id, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM animals
      WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.delete_all()
      sql = "DELETE FROM animals"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM animals"
      animals = SqlRunner.run(sql)
      result = animals.map { |animal| Animal.new(animal)}
      return result
    end

    def self.find(id)
      sql = "SELECT * FROM animals
      WHERE id = $1"
      values = [id]
      animal = SqlRunner.run(sql, values).first
      result = Animal.new(animal)
      return result
    end

    def customer()
      customer = Customer.find(@customer_id)
      return customer
    end


  end
