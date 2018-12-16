module Types
  class LinkType < Types::BaseObject
    graphql_name "Link"

    field :id, ID, null: false
    field :url, String, null: false
    field :description, String, null: false
    field :posteBy, UserType, null: false, method: :user
  end
end
