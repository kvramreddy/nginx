# # encoding: utf-8

# Inspec test for recipe nginx::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_installed }
  it { should be_running }
  it { should be_enabled }
end

describe command('curl -s -o /dev/null -w "%{http_code}" http://localhost') do
  its('stdout') { should match '200' }
end
