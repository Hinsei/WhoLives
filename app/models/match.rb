class Match < ApplicationRecord

	# Scopes
	scope :not_full, -> { where("player_1 IS NOT NULL AND player_2 IS NULL") }

	# Status
	enum status: { ongoing: 0, finished: 1 }
end
