require 'pg'

class Database
  def initialize(
    dbname, user, password, host, port
  )
    @connection = PG.connect(
      dbname: dbname,
      user: user,
      password: password,
      host: host,
      port: port
    )
    @current_ids = {}
  end


  def saveObject(object)
    db_row = object.db_row.filter { |k, v| !v.nil? }
    table_name = object.db_table_name
    keys = db_row.keys.join(', ')
    values = db_row.values.map { |v| "'#{v}'" }.join(', ')
    @connection.exec("INSERT INTO #{table_name} (#{keys}) VALUES (#{values});")
  end

  def get_next_id(table_name, id_name)
    result = @connection.exec("SELECT MAX(#{id_name}) FROM #{table_name};")
    result[0]['max'].to_i + 1
  end
end