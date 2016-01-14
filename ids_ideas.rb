require 'csv'

def get_ids
  ids = Array.new
  ideas = CSV.read('/home/ideas4all/Documentos/banc_sabadell.csv')
  ideas.each do |row|
    ids << row[0].to_i
  end
  ids = ids.drop(1)
  puts ids.inspect
end

get_ids
