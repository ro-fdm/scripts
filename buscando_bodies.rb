require 'csv'
def get_ids_ideas
  ids = Array.new
  ideas = CSV.read('/home/ideas4all/Documentos/ideas_sin_body.csv')
  ideas.each do |row1|
    id  = row1[0]
    ids << id
  end
  ids.shift #Delete the first element of array
  search_bodies(ids)
end

def search_bodies(ids)
  ideas = Hash.new
  ids.each do |id|
    string = "idea_" + "#{id}" +"_body_editor"
    log = File.open('/home/ideas4all/Documentos/production.log.3.txt').grep(/idea_#{id}_body_editor/)
    l = log[0].split(" Parameters: ")[1]
    a = eval(l) # transform string to hash
    body = a[string]
    ideas[id] = body
  end
  create_csv_id_body(ideas)
end

def create_csv_id_body(ideas)
  CSV.open('/home/ideas4all/Documentos/ideas_bodies.csv', 'w') do |csv_object|
    ideas.to_a.each do |row|
      csv_object << row
    end
  end
end

get_ids_ideas
