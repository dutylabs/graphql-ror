module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :allMovies, [MovieType], null: true do
      description "A list of all the movies"
    end
    def all_movies
      Movie.all
    end

    field :movie, MovieType, null: true do
      description "Return a movie"
      argument :id, ID, required: true
    end
    def movie(id:)
      Movie.find(id)
    end
  end
end
