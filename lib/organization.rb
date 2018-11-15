# frozen_string_literal: true

class Organization

  def self.fields
    %w[name details]
  end

  def readable_format
    @data
    # e.g.
    # Shopify
    # https://shopify.com
    # Tags: tag one, tag two
    # Tickets: ticket one, ticket two
  end

end
