require 'csv'

def get_ids
  ids = Array.new
  labels_sacs = Hash.new
  ideas = CSV.read('/home/ideas4all/Documentos/ideas_etiquetar.csv')
  ideas.each do |row|
    labels_sacs[row[2]] = row[3]
    #ids << row[0].to_i
  end

    ideas.each do |row|
      if (row[2] =~ /^archivada/)
        ids << row[0].to_i
       end
    end
  #ids = ids.drop(1)
  puts ids.inspect
  #puts labels_sacs.keys
end

get_ids