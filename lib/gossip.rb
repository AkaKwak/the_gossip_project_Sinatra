#gossip.rb

class Gossip
  attr_accessor :author, :content


  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    view_gossips = self.all
    adjusted_index = id - 1
    return view_gossips[adjusted_index] if adjusted_index >= 0 && adjusted_index < view_gossips.size
  nil  # Retourne nil si l'ID n'est pas valide
  end

  def self.update(id, author, content)
    update_gossips = self.all
    gossips[id] = Gossip.new(author, content)  # Met à jour le potin en mémoire

    # Réécrit le fichier CSV
    CSV.open("./db/gossip.csv", "wb") do |csv|
      gossips.each do |gossip|
        csv << [gossip.author, gossip.content]
      end
    end
  end

end