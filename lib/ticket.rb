# frozen_string_literal: true

class Ticket

  def self.fields
    %w[type subject description priority status]
  end

  def readable_format
    @data
    # Subject
    # Submitted by: Kari Matthews
    # Assigned to: Another Person
    # Priority: High
    # Status:
    # Description: akjdsfh akdjsfh sdh
    # Due at:
    # Organization:
  end

end
