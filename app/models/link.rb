class Link < ApplicationRecord
  validates_presence_of :url, :description
end
