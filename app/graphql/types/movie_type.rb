module Types
  class MovieType < Types::BaseObject
    graphql_name "Movie"
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true

    field :reviews, [ReviewType], null: false
    def reviews
      object.reviews
    end
  end
end
