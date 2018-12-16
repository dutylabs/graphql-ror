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

  describe "get all links" do
    # provide a query string for `result`
    let(:query_string) { %|{ allLinks { id } }| }

    context "when there are no links" do
      it "is nil" do
        # calling `result` executes the query
        expect(result["data"]["links"]).to eq(nil)
      end
    end
    context "when there's a single link" do
      it "shows the link's id" do
        link = create(:link)
        link_id = result["data"]["allLinks"].first["id"]
        expect(link_id).to eq(link.id.to_s)
      end
    end
  end
end