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