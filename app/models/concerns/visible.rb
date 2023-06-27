module Visible
	extend ActiveSupport::Concern

	VALID_STATUSES = %w[public private]

	validates :status, inclusion: { in: VALID_STATUSES }

	def private?
		status == 'private'
	end
end