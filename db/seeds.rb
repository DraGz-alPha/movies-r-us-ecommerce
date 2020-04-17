MovieGenre.destroy_all
MovieProducer.destroy_all
MovieOrder.destroy_all
Genre.destroy_all
Producer.destroy_all
Order.destroy_all
Movie.destroy_all
Customer.destroy_all
Province.destroy_all
Page.destroy_all

API_KEY = '7c518daaea75bf24a571c434be285147'
BASE_POSTER_URL = 'http://image.tmdb.org/t/p/w185/'
NUMBER_OF_PAGES = 7
current_page = 1

Province.create(name: 'Alberta', pst_rate: 0, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'British Columbia', pst_rate: 0.07, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'Manitoba', pst_rate: 0.07, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'New Brunswick', pst_rate: 0, gst_rate: 0, hst_rate: 0.15)
Province.create(name: 'Newfoundland and Labrador', pst_rate: 0, gst_rate: 0, hst_rate: 0.15)
Province.create(name: 'Northwest Territories', pst_rate: 0, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'Nova Scotia', pst_rate: 0, gst_rate: 0, hst_rate: 0.15)
Province.create(name: 'Nunavut', pst_rate: 0, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'Ontario', pst_rate: 0, gst_rate: 0, hst_rate: 0.13)
Province.create(name: 'Prince Edward Island', pst_rate: 0, gst_rate: 0, hst_rate: 0.15)
Province.create(name: 'Quebec', pst_rate: 9.975, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'Saskatchewan', pst_rate: 0.06, gst_rate: 0.05, hst_rate: 0)
Province.create(name: 'Yukon', pst_rate: 0, gst_rate: 0.05, hst_rate: 0)

NUMBER_OF_PAGES.times do 
  movies_response = HTTParty.get("https://api.themoviedb.org/3/discover/movie?api_key=#{API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=#{current_page}")
  movies = JSON.parse(movies_response.body)

  movies['results'].each do |movie|
    if movie['original_language'] == "en" then
      movie_response = HTTParty.get("https://api.themoviedb.org/3/movie/#{movie['id']}?api_key=#{API_KEY}&language=en-US")
      movie_data = JSON.parse(movie_response.body)
      
      movie_imdb_number = movie_data['imdb_id']
      movie_title = movie_data['original_title']
      movie_language = movie_data['original_language']
      movie_description = movie_data['overview']
      movie_poster = BASE_POSTER_URL + movie_data['poster_path']
      movie_release_date = movie_data['release_date']
      movie_length = movie_data['runtime']
      movie_price = rand(4.99..39.99)
      # puts "#{movie_data['original_title']} #{movie_data['genres']}"

      if movie_imdb_number and movie_title and movie_description and movie_data['genres'].length > 0 && movie_data['production_companies'].length > 0 then
        current_movie = Movie.create(imdb_number: movie_imdb_number,
                                    title: movie_title,
                                    language: movie_language,
                                    description: movie_description,
                                    poster: movie_poster,
                                    release_date: movie_release_date,
                                    length: movie_length,
                                    price: movie_price)

        movie_data['genres'].each do |genre|
          current_genre = Genre.where(name: genre['name']).first
          if current_genre.blank? then
            current_genre = Genre.create(name: genre['name'])
          end
          MovieGenre.create(movie: current_movie, genre: current_genre)
        end
        movie_data['production_companies'].each do |producer|
          current_producer = Producer.where(name: producer['name']).first
          if current_producer.blank? then
            current_producer = Producer.create(name: producer['name'])
          end
          MovieProducer.create(movie: current_movie, producer: current_producer)
        end
      end
    end
  end

  current_page += 1
end

Page.create(title: 'Contact',
  content: "Email: movies-r-us@gmail.com",
  permalink: 'contact')

Page.create(title: 'About',
  content: "Movies R Us is an online movie store tailored specifically for movie enthusiasts, 
            providing an amazing selection of movies for purchase to customers around the globe. 
            Movies R Us currently employs 5 hard-working and passionate developers that strive 
            to offer the best possible user experience for you, the die-hard movie fan. ",
  permalink: 'about')

puts "Created #{Movie.count} Movies."
puts "Created #{Genre.count} Genres."
puts "Created #{Producer.count} Producers."
puts "Created #{MovieGenre.count} Movie Genres."
puts "Created #{MovieProducer.count} Movie Producers."
puts "Created #{Province.count} Provinces."

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?