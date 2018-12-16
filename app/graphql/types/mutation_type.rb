module Types
  class MutationType < Types::BaseObject
    field :createLink, LinkType, null: true do
      argument :url, String, required: true
      argument :description, String, required: false
    end
    def create_link(url:, description:)
      Link.create!(
        url: url,
        description: description,
        user: context[:current_user],
      )
    rescue ActiveRecord::RecordInvalid => e
      # this would catch all validation errors and translate them to GraphQL::ExecutionError
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
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

      context[:session][:token] = token
      OpenStruct.new({
        user: user,
        token: token,
      })
    end

    field :createVote, VoteType, null: true do
      argument :linkId, ID, required: true
    end

    def create_vote(link_id:)
      Vote.create!(
        link: Link.find_by(id: link_id),
        user: context[:current_user],
      )
    end
  end
end
