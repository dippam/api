require File.expand_path('../application', __FILE__)
Dippam::Application.initialize!
Mime::Type.register 'application/text', :txt
Mime::Type.register 'application/json', :facets
