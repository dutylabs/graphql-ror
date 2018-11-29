module Types
  class MutationType < Types::BaseObject
    field :createMovie, MovieType, null: true do
      argument :title, String, required: true
      argument :description, String, required: false
    end
    def create_movie(title:, description:)
      Movie.create(
        title: title,
        description: description
      )
    end
  end
end
