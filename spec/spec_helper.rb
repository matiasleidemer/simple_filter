$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_filter'

require File.dirname(__FILE__) + '/support/connection'

class Product < ActiveRecord::Base
end

class ProductFilter < SimpleFilter::Base
end
