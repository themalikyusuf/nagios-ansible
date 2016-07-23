require 'open3'
require_relative 'vars'

# Scenario: Setup and Create User, Group and Add User to Group
When(/^I create a user and groups$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'group'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

And(/^the created user should exists$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'cut -d: -f1 /etc/passwd | grep nagios'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("nagios")
end

# Scenario: Install Build Dependencies
When(/^I Install Build Dependencies$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'build_setup'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Download Nagios
When(/^I Download Nagios source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'dwld_nagios'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the source code should be extracted$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'ls | grep 'nagios-4.1.1''"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to eq("nagios-4.1.1\n")
end

# Scenario: Configure Nagios
When(/^I Configure Nagios source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'cfg_nagios'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Install Nagios and init scripts
When(/^I Install Nagios and init scripts$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'nagios_init'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the web server user should exists$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'cut -d: -f1 /etc/passwd | grep www-data'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("www-data")
end

# Scenario: Download Nagios Plugin
When(/^I Download Nagios Plugin source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'dwld_nagios_plugin'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the Nagios Plugin source code should be extracted$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'ls | grep 'nagios-plugins-2.1.1''"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to eq("nagios-plugins-2.1.1\n")
end

# Scenario: Configure Nagios Plugin
When(/^I Configure Nagios Plugin source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'cfg_nagios_plugin'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Download NRPE
When(/^I Download NRPE source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'dwld_nrpe'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the NRPE source code should be extracted$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'ls | grep 'nrpe-2.15''"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to eq("nrpe-2.15\n")
end

# Scenario: Configure NRPE
When(/^I Configure NRPE source code$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'cfg_nrpe'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Modify extended Internet daemon to allow our IP restart_xinetd
When(/^I add the IP to the xinetd file$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'xinetd'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^([^"]*) should be running$/) do |pkg|
  case pkg
  when 'nagios', 'apache2', 'xinetd'
    output, error, status = Open3.capture3 "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'sudo service #{pkg} status'"
    expect(status.success?).to eq(true)

    if pkg == 'xinetd'
      expect(output).to match("#{pkg} start/running")
    elsif pkg == 'nagios'
      expect(output).to match("is running")
    else
      expect(output).to match("#{pkg} is running")
    end

  else
    raise 'Not Implemented'
  end
end

# Scenario: Uncomment Nagios server config directory line
When(/^I uncomment Nagios server config directory line$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'uncomment'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create directory to store config file for each server
When(/^I create directory to store config file for each server$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'create_dir'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^the directory should exists$/) do
  cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'ls /usr/local/nagios/etc/ | grep servers'"
  output, error, status = Open3.capture3 "#{cmd}"
  expect(status.success?).to eq(true)
  expect(output).to match("servers")
end

# Scenario: Find and replace email
When(/^I carry out the find and replace email task$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'replace_email'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Add check_nrpe command to Nagios config
When(/^I add check_nrpe command to Nagios config$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'add_command'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Enable the Apache Rewrite and CGI modules
When(/^I enable the Apache Rewrite and CGI modules$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'a2enmod'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create admin username and password for authentication
When(/^I create admin username and password for authentication$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'htpasswd'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create symbolic links
When(/^I create symbolic link$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'symlink_services'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

# Scenario: Create a new config file for each host
When(/^I create a new config file for each host$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.nagios.yml --tags 'create_host_config'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

