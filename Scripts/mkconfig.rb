#!/usr/bin/ruby

require 'json'
require 'rbconfig'

contents = STDIN.read()

my_hash = JSON.parse( contents )

tst =  RbConfig::CONFIG

data = JSON.pretty_generate( tst )
File.write("fred.json",data)

my_hash["tags"]["arch"] = RbConfig::CONFIG["host_cpu"]
my_hash["tags"]["os"]   = RbConfig::CONFIG["target_os"]

# out = JSON.generate( my_hash )
out = JSON.pretty_generate( my_hash )

STDOUT.write(out + "\n" )

