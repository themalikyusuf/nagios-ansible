Feature: Configure Nagios


  Scenario: Setup and Create User, Group and Add User to Group
    When I create a user and group
    Then it should be successful
    And the created user should exists

  Scenario: Install Build Dependencies
    When I Install Build Dependencies
    Then it should be successful

  Scenario: Download Nagios
    When I Download Nagios source code
    Then it should be successful
    And the source code should be extracted

  Scenario: Configure Nagios
    When I Configure Nagios source code
    Then it should be successful

  Scenario: Install Nagios and init scripts
    When I Install Nagios and init scripts
    Then it should be successful
    And the web server user should exists

  Scenario: Download Nagios Plugin
    When I Download Nagios Plugin source code
    Then it should be successful
    And the Nagios Plugin source code should be extracted

  Scenario: Configure Nagios Plugin
    When I Configure Nagios Plugin source code
    Then it should be successful

  Scenario: Download NRPE
    When I Download NRPE source code
    Then it should be successful
    And the NRPE source code should be extracted

  Scenario: Configure NRPE
    When I Configure NRPE source code
    Then it should be successful

  Scenario: Modify extended Internet daemon to allow our IP
    When I add the IP to the xinetd file
    Then it should be successful
    And xinetd should be running

  Scenario: Uncomment Nagios server config directory line
    When I uncomment Nagios server config directory line
    Then it should be successful

  Scenario: Create directory to store config file for each server
    When I create directory to store config file for each server
    Then it should be successful
    And the directory should exists

  Scenario: Find and replace email
    When I carry out the find and replace email task
    Then it should be successful

  Scenario: Add check_nrpe command to Nagios config
    When I add check_nrpe command to Nagios config
    Then it should be successful

  Scenario: Enable the Apache Rewrite and CGI modules
    When I enable the Apache Rewrite and CGI modules
    Then it should be successful

  Scenario: Create admin username and password for authentication
    When I create admin username and password for authentication
    Then it should be successful

  Scenario: Create symbolic links
    When I create symbolic link
    Then it should be successful
    And nagios should be running
    And apache2 should be running



