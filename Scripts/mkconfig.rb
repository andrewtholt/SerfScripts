#!/usr/bin/ruby

require 'json'

contents = File.read('config.json')


my_hash = JSON.parse( contents )

my_hash["tags"]["arch"] = "x86_64"

out = JSON.generate( my_hash )

print out

File.write('new.json', out )

