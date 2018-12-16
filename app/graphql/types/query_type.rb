module Types
  class QueryType < Types::BaseObject
    field :allLinks, [LinkType], null: true do
      description "A list of all the links"
    end
    def all_links
      Link.all
    end

    field :link, LinkType, null: true do
      description "Return a link"
      argument :id, ID, required: true
    end
    def link(id:)
      Link.find(id)
    end

    field :allLinksConnection, LinkType.connection_type, null: false
    def all_links_connection
      Link.all
    end
  end
end
