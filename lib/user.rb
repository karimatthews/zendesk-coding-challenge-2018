# frozen_string_literal: true

class User < Resource

  def self.fields
    %w[name alias active verified email phone signature suspended role]
  end

  def readable_format
    @data
    # Name (alias)
    # Email | Phone
    # Role
  end

end
