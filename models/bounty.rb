require('pg')

class Bounty

  attr_accessor :name, :bounty_value, :last_known_location, :collected_by
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @last_known_location = options['last_known_location']
    @collected_by = options['collected_by']
  end

  def save()
    db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
    sql = "INSERT INTO bounty_tracker
    (
      name,
      bounty_value,
      last_known_location,
      collected_by
    )
    VALUES
    (
      $1, $2, $3, $4
      )
      RETURNING *;
      "

      values = [@name, @bounty_value, @last_known_location, @collected_by]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i
      db.close()
    end

    def update()
      db = PG.connect ({dbname: 'space_cowboys', host: 'localhost' })
      sql = "UPDATE bounty_tracker
      SET (
        name,
        bounty_value,
        last_known_location,
        collected_by
        )=
        (
          $1, $2, $3, $4
          ) WHERE id = $5;
          "

      values = [@name, @bounty_value, @last_known_location, @collected_by, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
    end

    def delete()
      db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
      sql = "DELETE FROM bounty_tracker WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
    end


    def Bounty.all()
      db = PG.connect ({ dbname: 'space_cowboys', host: 'localhost'})
      sql = "SELECT * FROM bounty_tracker"
      values = []
      db.prepare("all", sql)
      bounties = db.exec_prepared("all", values)
      db.close()
      return bounties.map {|bounty| Bounty.new(bounty)}

    end

    def Bounty.find(id)
      db = PG.connect({ dbname: 'space_cowboys', host: 'localhost'})
      sql = "SELECT * FROM bounty_tracker WHERE id = $1"
      values = [id]
      db.prepare("find", sql)
      bounties = db.exec_prepared("find", values)
      db.close
      return bounties.map {|bounty| Bounty.new(bounty)}
    end
end
