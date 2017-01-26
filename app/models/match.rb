class Match < ApplicationRecord
	enum :status [:ongoing, :finished]
end
