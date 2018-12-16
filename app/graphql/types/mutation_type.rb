module Types
  class MutationType < Types::BaseObject
    field :createLink, LinkType, null: true do
      argument :url, String, required: true
      argument :description, String, required: false
    end
    def create_link(url:, description:)
      Link.create(
        url: url,
        description: description,
      )
    end

    field :createUser, UserType, null: true do
      argument :name, String, required: true
      argument :authProvider, AuthProviderInput, required: true
    end
    def create_user(name:, auth_provider:)
      User.create!(
        name: name,
        email: auth_provider.email.email,
        password: auth_provider.email.password,
      )
    end

    field :loginUser, AuthResponse, null: true do
      argument :authProvider, AuthProviderInput, required: true
    end

    def login_user(auth_provider:)
      user = User.find_by email: auth_provider.email.email
      return unless user
      return unless user.authenticate(auth_provider.email.password)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      OpenStruct.new({
        user: user,
        token: token,
      })
    end
  end
end
