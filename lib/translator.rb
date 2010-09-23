require 'rubygems'
require 'json'

require 'net/http'
require 'uri'

require 'translator/translate'
require 'translator/confuddler'

module Translator  
  class TranslationException < Exception; end;
end

