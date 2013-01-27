#!/usr/bin/env ruby

APP_PATH = File.expand_path('../../config/application',  __FILE__)
require File.expand_path('../../config/boot',  __FILE__)

require File.expand_path('../lectures', __FILE__)

@lectures.each do |lecture|
  l = Lecture.new
  l.title = lecture[0]
  l.provider = lecture[1]
  l.save
end

Lecture.import
