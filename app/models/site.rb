class Site < ActiveRecord::Base
  def self.locate(subdomain)
    site = self.find_by_subdomain(subdomain)
    site ||= self.new(subdomain: 'www', short_title: 'DIPPAM', title: 'DIPPAM')
    site
  end
end
