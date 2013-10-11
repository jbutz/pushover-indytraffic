class Record
	include Mongoid::Document

	field :message, type: String
	field :expires, type: Time
end