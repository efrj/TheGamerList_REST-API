require 'open-uri'

puts "Limpando banco de dados..."

Game.destroy_all
PlatformsInformation.destroy_all
Platform.destroy_all
Generation.destroy_all
Genre.destroy_all
Softhouse.destroy_all
Banner.destroy_all
Content.destroy_all

puts "Criando Gerações de Consoles..."

generations_data = [
  {
    name: "Terceira Geração",
    starting_year: 1983,
    description: "A era dos 8 bits, marcada pelo Nintendo Entertainment System (NES) e Master System.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/320px-NES-Console-Set.jpg"
  },
  {
    name: "Quarta Geração",
    starting_year: 1988,
    description: "A geração dos 16 bits com Super Nintendo e Mega Drive dominando o mercado.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/SNES-Mod1-Console-Set.jpg/320px-SNES-Mod1-Console-Set.jpg"
  },
  {
    name: "Quinta Geração",
    starting_year: 1993,
    description: "A transição para os gráficos 3D com PlayStation, Nintendo 64 e Sega Saturn.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/PSX-Console-wController.jpg/320px-PSX-Console-wController.jpg"
  },
  {
    name: "Sexta Geração",
    starting_year: 1998,
    description: "PlayStation 2, GameCube, Xbox e Dreamcast trazendo DVDs e jogos online.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/PS2-Versions.jpg/320px-PS2-Versions.jpg"
  },
  {
    name: "Sétima Geração",
    starting_year: 2005,
    description: "HD Gaming com Xbox 360, PlayStation 3 e o inovador Wii.",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Xbox-360S-Console-Set.jpg/320px-Xbox-360S-Console-Set.jpg"
  }
]

generations = {}
generations_data.each do |gen_data|
  gen = Generation.create!(
    name: gen_data[:name],
    starting_year: gen_data[:starting_year],
    description: gen_data[:description]
  )
  
  if gen_data[:image_url]
    begin
      file = URI.open(gen_data[:image_url])
      gen.image.attach(io: file, filename: "#{gen.name.parameterize}.jpg")
      puts "  #{gen.name} criada com imagem"
    rescue => e
      puts "  #{gen.name} criada sem imagem: #{e.message}"
    end
  end
  
  generations[gen_data[:name]] = gen
end

puts "\nCriando Plataformas..."

platforms_data = [
  { name: "Nintendo Entertainment System (NES)", generation: "Terceira Geração", release_year: 1983, description: "Console de 8 bits que revolucionou a indústria dos games." },
  { name: "Super Nintendo (SNES)", generation: "Quarta Geração", release_year: 1990, description: "Console de 16 bits da Nintendo com jogos inesquecíveis." },
  { name: "Mega Drive (Genesis)", generation: "Quarta Geração", release_year: 1988, description: "Console de 16 bits da Sega que competiu fortemente com a Nintendo." },
  { name: "PlayStation", generation: "Quinta Geração", release_year: 1994, description: "Primeiro console da Sony que mudou o mercado de games." },
  { name: "Nintendo 64", generation: "Quinta Geração", release_year: 1996, description: "Console de 64 bits da Nintendo com controle analógico inovador." },
  { name: "PlayStation 2", generation: "Sexta Geração", release_year: 2000, description: "Console mais vendido da história com enorme biblioteca de jogos." },
  { name: "GameCube", generation: "Sexta Geração", release_year: 2001, description: "Console compacto da Nintendo com jogos exclusivos memoráveis." },
  { name: "Xbox", generation: "Sexta Geração", release_year: 2001, description: "Primeiro console da Microsoft, trazendo Halo e Xbox Live." },
  { name: "Xbox 360", generation: "Sétima Geração", release_year: 2005, description: "Console HD com forte presença online e achievements." },
  { name: "PlayStation 3", generation: "Sétima Geração", release_year: 2006, description: "Console com Blu-ray e exclusivos de alto nível." },
  { name: "Nintendo Wii", generation: "Sétima Geração", release_year: 2006, description: "Console revolucionário com controles por movimento." }
]

platforms = {}
platforms_data.each do |plat_data|
  plat = Platform.create!(
    name: plat_data[:name],
    generation: generations[plat_data[:generation]],
    release_year: plat_data[:release_year],
    description: plat_data[:description]
  )
  platforms[plat_data[:name]] = plat
  puts "  #{plat.name}"
end

puts "\nCriando Gêneros..."

genres_data = [
  { name: "Ação", description: "Jogos focados em reflexos rápidos e coordenação física." },
  { name: "Aventura", description: "Jogos focados em narrativa e exploração." },
  { name: "RPG", description: "Jogos de interpretação de personagens com progressão e história." },
  { name: "Plataforma", description: "Jogos onde o jogador controla um personagem pulando entre plataformas." },
  { name: "Corrida", description: "Jogos de corrida de veículos." },
  { name: "Esportes", description: "Simulações de esportes reais." },
  { name: "Luta", description: "Jogos de combate um contra um." },
  { name: "Tiro", description: "Jogos focados em combate com armas de fogo." },
  { name: "Puzzle", description: "Jogos que desafiam a mente com quebra-cabeças." },
  { name: "Estratégia", description: "Jogos que requerem planejamento e táticas." }
]

genres = {}
genres_data.each do |genre_data|
  genre = Genre.create!(
    name: genre_data[:name]
  )
  genres[genre_data[:name]] = genre
  puts "  #{genre.name}"
end

puts "\nCriando Softhouses..."

softhouses_data = [
  { name: "Nintendo", description: "Empresa japonesa pioneira em videogames, criadora de Mario e Zelda." },
  { name: "Sega", description: "Empresa japonesa famosa por Sonic e outros clássicos." },
  { name: "Capcom", description: "Desenvolvedora japonesa conhecida por Street Fighter e Mega Man." },
  { name: "Square (Square Enix)", description: "Criadora de Final Fantasy e Dragon Quest." },
  { name: "Konami", description: "Desenvolvedora de Metal Gear, Castlevania e muitos outros." },
  { name: "Namco", description: "Criadora de Pac-Man e Tekken." },
  { name: "Rare", description: "Desenvolvedora britânica famosa por jogos do Nintendo 64." },
  { name: "Naughty Dog", description: "Desenvolvedora americana de Crash Bandicoot e Uncharted." },
  { name: "Bungie", description: "Criadora da franquia Halo." },
  { name: "Sony Computer Entertainment", description: "Divisão de games da Sony." }
]

softhouses = {}
softhouses_data.each do |soft_data|
  soft = Softhouse.create!(
    name: soft_data[:name],
    description: soft_data[:description]
  )
  softhouses[soft_data[:name]] = soft
  puts "  #{soft.name}"
end

puts "\nCriando Jogos..."

games_data = [
  # NES
  { title: "Super Mario Bros.", platform: "Nintendo Entertainment System (NES)", genre: "Plataforma", softhouse: "Nintendo", release_year: 1985, description: "O jogo que salvou a indústria dos videogames." },
  { title: "The Legend of Zelda", platform: "Nintendo Entertainment System (NES)", genre: "Aventura", softhouse: "Nintendo", release_year: 1986, description: "Primeira aventura de Link em Hyrule." },
  { title: "Mega Man 2", platform: "Nintendo Entertainment System (NES)", genre: "Ação", softhouse: "Capcom", release_year: 1988, description: "Um dos melhores jogos da franquia Mega Man." },
  
  # SNES
  { title: "Super Mario World", platform: "Super Nintendo (SNES)", genre: "Plataforma", softhouse: "Nintendo", release_year: 1990, description: "Jogo de lançamento do SNES e um dos melhores da franquia." },
  { title: "The Legend of Zelda: A Link to the Past", platform: "Super Nintendo (SNES)", genre: "Aventura", softhouse: "Nintendo", release_year: 1991, description: "Obra-prima da era 16 bits." },
  { title: "Chrono Trigger", platform: "Super Nintendo (SNES)", genre: "RPG", softhouse: "Square (Square Enix)", release_year: 1995, description: "Um dos melhores RPGs de todos os tempos." },
  { title: "Street Fighter II", platform: "Super Nintendo (SNES)", genre: "Luta", softhouse: "Capcom", release_year: 1992, description: "Jogo que definiu o gênero de luta." },
  
  # Mega Drive
  { title: "Sonic the Hedgehog", platform: "Mega Drive (Genesis)", genre: "Plataforma", softhouse: "Sega", release_year: 1991, description: "O mascote da Sega em sua primeira aventura." },
  { title: "Sonic the Hedgehog 2", platform: "Mega Drive (Genesis)", genre: "Plataforma", softhouse: "Sega", release_year: 1992, description: "Sonic e Tails juntos pela primeira vez." },
  { title: "Streets of Rage 2", platform: "Mega Drive (Genesis)", genre: "Ação", softhouse: "Sega", release_year: 1992, description: "Clássico beat 'em up com trilha sonora inesquecível." },
  
  # PlayStation
  { title: "Final Fantasy VII", platform: "PlayStation", genre: "RPG", softhouse: "Square (Square Enix)", release_year: 1997, description: "RPG revolucionário que levou a série para o 3D." },
  { title: "Metal Gear Solid", platform: "PlayStation", genre: "Ação", softhouse: "Konami", release_year: 1998, description: "Jogo de stealth que definiu o gênero." },
  { title: "Crash Bandicoot", platform: "PlayStation", genre: "Plataforma", softhouse: "Naughty Dog", release_year: 1996, description: "Mascote não-oficial do PlayStation." },
  { title: "Resident Evil", platform: "PlayStation", genre: "Ação", softhouse: "Capcom", release_year: 1996, description: "Jogo que popularizou o survival horror." },
  
  # Nintendo 64
  { title: "Super Mario 64", platform: "Nintendo 64", genre: "Plataforma", softhouse: "Nintendo", release_year: 1996, description: "Mario em 3D revolucionando os jogos de plataforma." },
  { title: "The Legend of Zelda: Ocarina of Time", platform: "Nintendo 64", genre: "Aventura", softhouse: "Nintendo", release_year: 1998, description: "Considerado um dos melhores jogos de todos os tempos." },
  { title: "GoldenEye 007", platform: "Nintendo 64", genre: "Tiro", softhouse: "Rare", release_year: 1997, description: "FPS revolucionário baseado no filme de James Bond." },
  { title: "Mario Kart 64", platform: "Nintendo 64", genre: "Corrida", softhouse: "Nintendo", release_year: 1996, description: "Corridas divertidas com personagens da Nintendo." },
  
  # PlayStation 2
  { title: "Grand Theft Auto: San Andreas", platform: "PlayStation 2", genre: "Ação", softhouse: "Capcom", release_year: 2004, description: "Épica aventura em mundo aberto ambientada nos anos 90." },
  { title: "Shadow of the Colossus", platform: "PlayStation 2", genre: "Aventura", softhouse: "Sony Computer Entertainment", release_year: 2005, description: "Arte em forma de jogo com batalhas épicas." },
  { title: "God of War", platform: "PlayStation 2", genre: "Ação", softhouse: "Sony Computer Entertainment", release_year: 2005, description: "Kratos em sua primeira jornada de vingança." },
  
  # GameCube
  { title: "The Legend of Zelda: The Wind Waker", platform: "GameCube", genre: "Aventura", softhouse: "Nintendo", release_year: 2002, description: "Zelda com visual cel-shaded e exploração marítima." },
  { title: "Metroid Prime", platform: "GameCube", genre: "Ação", softhouse: "Nintendo", release_year: 2002, description: "Metroid em primeira pessoa mantendo a essência da série." },
  { title: "Super Smash Bros. Melee", platform: "GameCube", genre: "Luta", softhouse: "Nintendo", release_year: 2001, description: "Jogo de luta definitivo com personagens Nintendo." },
  
  # Xbox
  { title: "Halo: Combat Evolved", platform: "Xbox", genre: "Tiro", softhouse: "Bungie", release_year: 2001, description: "FPS que definiu uma geração de consoles." },
  { title: "Halo 2", platform: "Xbox", genre: "Tiro", softhouse: "Bungie", release_year: 2004, description: "Continuação épica com multiplayer revolucionário." },
  
  # Xbox 360
  { title: "Halo 3", platform: "Xbox 360", genre: "Tiro", softhouse: "Bungie", release_year: 2007, description: "Conclusão épica da trilogia original." },
  { title: "Gears of War", platform: "Xbox 360", genre: "Tiro", softhouse: "Bungie", release_year: 2006, description: "Third-person shooter com sistema de cobertura inovador." },
  
  # PS3
  { title: "The Last of Us", platform: "PlayStation 3", genre: "Ação", softhouse: "Naughty Dog", release_year: 2013, description: "História emocionante em mundo pós-apocalíptico." },
  { title: "Uncharted 2: Among Thieves", platform: "PlayStation 3", genre: "Ação", softhouse: "Naughty Dog", release_year: 2009, description: "Aventura cinematográfica de Nathan Drake." },
  
  # Wii
  { title: "Super Mario Galaxy", platform: "Nintendo Wii", genre: "Plataforma", softhouse: "Nintendo", release_year: 2007, description: "Mario explorando planetas com gravidade inovadora." },
  { title: "The Legend of Zelda: Twilight Princess", platform: "Nintendo Wii", genre: "Aventura", softhouse: "Nintendo", release_year: 2006, description: "Zelda épico com tons mais sombrios." }
]

games_data.each do |game_data|
  game = Game.create!(
    title: game_data[:title],
    platform: platforms[game_data[:platform]],
    genre: genres[game_data[:genre]],
    softhouse: softhouses[game_data[:softhouse]],
    release_year: game_data[:release_year],
    description: game_data[:description]
  )
  puts "  #{game.title}"
end

puts "\nCriando Conteúdos (Artigos/Notícias)..."

contents_data = [
  {
    title: "História dos Videogames",
    slug: "historia-dos-videogames",
    content: "Os videogames evoluíram desde simples jogos de arcade até experiências cinematográficas complexas. A jornada começou nos anos 70 com Pong e chegou aos modernos jogos em 4K com ray tracing."
  },
  {
    title: "Os Melhores RPGs da Era 16 Bits",
    slug: "melhores-rpgs-16-bits",
    content: "A era 16 bits produziu alguns dos melhores RPGs de todos os tempos, incluindo Chrono Trigger, Final Fantasy VI, e Secret of Mana. Estes jogos definiram o gênero por décadas."
  },
  {
    title: "Evolução dos Gráficos nos Games",
    slug: "evolucao-graficos-games",
    content: "De pixels simples a mundos fotorrealísticos, a evolução gráfica nos games é impressionante. Cada geração trouxe avanços significativos na forma como vemos e interagimos com os jogos."
  }
]

contents_data.each do |content_data|
  content = Content.create!(
    title: content_data[:title],
    slug: content_data[:slug],
    content: content_data[:content]
  )
  puts "  #{content.title}"
end

puts "\nCriando Banners..."

banners_data = [
  {
    title: "Retro Gaming Collection",
    description: "Explore nossa coleção completa de jogos clássicos",
    url_link: "/games"
  },
  {
    title: "Especial Nintendo",
    description: "Tudo sobre a história da Nintendo e seus jogos icônicos",
    url_link: "/contents/historia-nintendo"
  },
  {
    title: "PlayStation Classics",
    description: "Os melhores jogos das eras PlayStation",
    url_link: "/platforms/playstation"
  }
]

banners_data.each do |banner_data|
  banner = Banner.create!(
    title: banner_data[:title],
    description: banner_data[:description],
    url_link: banner_data[:url_link]
  )
  puts "  #{banner.title}"
end

puts "\nResumo do Seed:"
puts "  #{Generation.count} gerações"
puts "  #{Platform.count} plataformas"
puts "  #{Genre.count} gêneros"
puts "  #{Softhouse.count} softhouses"
puts "  #{Game.count} jogos"
puts "  #{Content.count} conteúdos"
puts "  #{Banner.count} banners"
puts "\nSeed concluído com sucesso!"
