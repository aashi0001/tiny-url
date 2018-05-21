require 'open-uri'
class Link < ApplicationRecord

	has_many :stats

	UNIQUE_ID_LENGTH = 6.freeze
	before_validation :smart_add_url_protocol
	validates :original_url, presence: true, on: :create, :format => URI::regexp(%w(http https))
	validates :original_url, uniqueness: true
	before_create :generate_short_url
	before_create :censor


	def generate_short_url
		url = ([*('a'..'z'), *('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
		old_url = Link.where(short_url: url).last
		if old_url.present?
		  self.generate_short_url
		else
		  self.short_url = url
		end
	end

	
end
