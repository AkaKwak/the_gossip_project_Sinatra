# controller.rb

class ApplicationController < Sinatra::Base

  ['/', '/index'].each do |path|
    get path do
      erb :index, locals: {gossips: Gossip.all}
    end
  end
  

  get %r{/gossips/(\d+)/?} do
    id = params['captures'].first.to_i
    gossip = Gossip.find(id)
    if gossip.nil?
      status 404  # Renvoie un statut 404 si le potin n'est pas trouvé
      return "Potin non trouvé"  # Affiche un message d'erreur
    end
    erb :show, locals: { gossip: gossip, id: id}
  end

  get '/gossips/:id/edit/' do
    id = params['id'].to_i
    gossip = Gossip.find(id)
    erb :edit, locals: { gossip: gossip, id: id }
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  post '/gossips/:id/edit/' do
    id = params['id'].to_i
    author = params['gossip_author']
    content = params['gossip_content']

    Gossip.update(author, content)

    redirect "/"
  end
# binding.pry
end