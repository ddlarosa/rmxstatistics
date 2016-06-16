# This file contains your application, it requires dependencies and necessary
# parts of the application.
require 'rubygems'
require 'ramaze'
require 'csv'
require 'tzinfo'
#require 'charlock_holmes'

# load rmxdb
require_relative '/home/rmx/rmx/rmxdb/lib/db'
require_relative '/home/rmx/rmx/rmxdb/lib/jobs'
require_relative './config/base'
require_relative './config/custom' if File.exists? __DIR__('config/custom.rb')

# initialize controllers and models
require_relative 'snippets/init'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

require __DIR__('controller/init')
