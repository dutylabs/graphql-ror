module Types
  class UserType < Types::BaseObject
    graphql_name "User"

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :links, [LinkType], null: false
    field :votes, [VoteType], null: false
  end

  class AuthProviderEmailInput < Types::BaseInputObject
    graphql_name "AUTH_PROVIDER_EMAIL"

    argument :email, String, required: true
    argument :password, String, required: true
  end

  class AuthProviderInput < Types::BaseInputObject
    graphql_name 'AuthProviderSignupData'

    argument :email, AuthProviderEmailInput, required: true
  end

  class AuthResponse < Types::BaseObject
    graphql_name 'AuthResponse'

    field :token, String, null: false
    field :user, UserType, null: false
  end
end
