RSpec.describe GraphqlSchema do
  let(:context) { {} }
  let(:variables) { {} }
  let(:result) {
    res = GraphqlSchema.execute(
      query_string,
      context: context,
      variables: variables,
    )
    if res["errors"]
      pp res
    end
    res
  }

  describe "create user" do
    # provide a query string for `result`
    let(:user) { build(:user) }
    let(:query_string) { %|mutation{
      createUser(
        name: "#{user.name}",
        authProvider: {
          email: {
            email: "#{user.email}",
            password: "#{user.password}"
          }
        }
      ) {
        id
        name
        email
      }
    }|
    }

    context "will create a new user" do
      it "shows the user's name and email" do
        user_email = result["data"]["createUser"]["email"]
        user_name = result["data"]["createUser"]["name"]
        expect(user_name).to eq(user.name)
      end
    end
    context "login user" do
      # override user and query
      let(:context) { { session: {} } }
      let(:user) { create(:user) }
      let(:query_string) { %|mutation{
        loginUser(
          authProvider: {
            email: {
              email: "#{user.email}",
              password: "#{user.password}"
            }
          }
        ) {
          token
          user {
            id
            name
            email
          }
        }
      }|
      }
      it "logins succesfully" do
        user_id = result["data"]["loginUser"]["user"]["id"]
        user_name = result["data"]["loginUser"]["user"]["name"]
        user_email = result["data"]["loginUser"]["user"]["email"]
        expect(user_id).to eq(user.id.to_s)
        expect(user_name).to eq(user.name)
        expect(user_email).to eq(user.email)
      end
    end
  end
end