require 'pg'

# This class is responsible for managing the connection to the database and saving objects to it.
# It uses the PG gem to connect to a PostgreSQL database.
class Database
  # @param dbname [String] the name of the database
  # @param user [String] the username to connect to the database
  # @param password [String] the password to connect to the database
  # @param host [String] the host where the database is running
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

  # Saves an IDatabaseObject to the database.
  # @param object [IDatabaseObject] the object to save
  # @return [Integer] the ID of the saved object
  def saveObject(object)
    db_row = object.db_row.filter { |k, v| !v.nil? }
    table_name = object.db_table_name
    primary_key = object.db_primary_key
    db_row[primary_key] = get_next_id(table_name, primary_key)
    keys = db_row.keys.join(', ')
    id = get_next_id(table_name, primary_key)
    values = db_row.values.map { |v| "'#{v}'" }.join(', ')
    @connection.exec("INSERT INTO #{table_name} (#{keys}) VALUES (#{values});")
    id
  end

  private

  def get_next_id(table_name, id_name)
    result = @connection.exec("SELECT MAX(#{id_name}) FROM #{table_name};")
    result[0]['max'].to_i + 1
  end
end