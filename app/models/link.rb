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

	def find_duplicate
	  Link.find_by_censor_url(self.censor_url)
	end

	def new_url?
	  find_duplicate.nil?
	end

	def censor
	  self.original_url.strip!
	  self.censor_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
	  self.censor_url = "http://#{self.censor_url}" 
	end


	private

	def smart_add_url_protocol
	  unless self.original_url[/\Ahttp:\/\//] || self.original_url[/\Ahttps:\/\//]
	    self.original_url = "http://#{self.original_url}"
	  end
	end
end
