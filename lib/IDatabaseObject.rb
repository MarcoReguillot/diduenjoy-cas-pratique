# This interface is used to define the methods that a class must implement in order to be saved to the database using the Database class.
class IDatabaseObject
  def db_row
    raise 'Not implemented'
  end

  def db_table_name
    raise 'Not implemented'
  end

  def db_primary_key
    raise 'Not implemented'
  end
end