require 'rubygems'
require 'rspec'
require_relative "../lib/ucb_ldap"

RSpec.configure do |config|
  # config block
end

$TESTING = true

include UCB::LDAP
UCB::LDAP.host = "ldap-test.berkeley.edu"

$binds ||= YAML.load(IO.read("#{File.dirname(__FILE__)}/binds.yml"))

def bind_for(bind_key)
  bind = $binds[bind_key] or raise("No bind found for '#{bind_key}'")
  UCB::LDAP.authenticate(bind["username"], bind["password"])
end

def address_bind
  bind_for("address")
end

def job_appointment_bind
  bind_for("job_appointment")
end

def namespace_bind
  bind_for("namespace")
end

def org_bind
  bind_for("org")
end

def affiliation_bind
  bind_for("affiliation")
end

def service_bind
  bind_for("affiliation")
end
