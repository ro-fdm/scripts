require 'csv'

def extract_dates_csv
  names = Hash.new
  emails = Hash.new
  fs = Hash.new
  duplicated = Hash.new
  users = CSV.read('/home/alia/Documentos/usuarios_santander_clientes_repetidos.csv')

  users.each do |row1|
    names[row1[0]] = row1[2][3..-1]
    emails[row1[0]] = row1[1]
    fs[row1[0]] = row1[3]
  end

  counted_duplicated_values(names, duplicated)
  counted_duplicated_values(emails, duplicated)
  counted_duplicated_values(fs, duplicated)
  #ids_array = keys_to_number(duplicated)
  #puts ids_array.inspect
  get_csv_duplicated_users(users, duplicated.keys)
  
end  

def counted_duplicated_values(dates, duplicated)
  counted = Hash.new(0)
  dates.each do |id, date|
    counted[date] +=1
  end
  counted_dates_duplicated = Hash.new
  counted_dates_duplicated = counted.delete_if {|k,v| v == 1}

  counted_dates_duplicated.each do | date_counted, number|
    dates.each do |id, date_dates|
     if date_counted == date_dates
        duplicated[id] = date_dates
      end
    end
  end
end

def get_csv_duplicated_users(users,ids)
  puts ids.inspect
  users_duplicated = Array.new
  users.each do |row|
    ids.each do |id|
      if row[0] == id
        users_duplicated << row
      end
    end
  end
  CSV.open('/home/alia/Documentos/usuarios_repetidos.csv', 'w') do |csv_object|
    users_duplicated.each do |row_array|
      csv_object << row_array
    end
  end
end

def keys_to_number(duplicated)
  ids = duplicated.keys
  ids_number = Array.new
  ids.each do |id|
    ids_number <<id.to_i
  end
  ids_number.to_csv
end

extract_dates_csv