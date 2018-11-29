module Types
  class ReviewType < Types::BaseObject
    graphql_name "Review"

    field :id, ID, null: false
    field :content, String, null: false
  end
end
