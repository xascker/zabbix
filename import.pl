#!/usr/bin/perl -w

use strict;
use warnings;
use JSON::RPC::Legacy::Client;
use XML::LibXML;
use File::Slurp;

my $url      = 'http://localhost/zabbix/api_jsonrpc.php'; # URL to Zabbix
my $userid   = "Admin";                                   # Zabbix API User ID
my $password = "zabbix";                                  # Zabbix API User Password
my $destFile  = "./templates";

my $client = new JSON::RPC::Legacy::Client;

my $authID = authenticate();
my $response = importTemplates();

importTemplates();
exit(0);

# Authenticate
sub authenticate{
  my $json = {
    jsonrpc => "2.0",
    method => "user.login",
    params => {
      user => "$userid",
      password => "$password"
    },
    id => 1
  };

  $response = $client->call($url, $json);
    die "Authentication failed\n" unless $response->content->{'result'};

  return $response->content->{'result'};

}

# Get Templates and import them
sub importTemplates{
  opendir(DIR, "./templates/");
  my @files = grep(/\.xml$/,readdir(DIR));
  closedir(DIR);

  foreach my $file (@files) {

     print "templatename: $file\n";
     my $buff = read_file ("./templates/$file") ;

        my $json = {
        jsonrpc => '2.0',
        method  => 'configuration.import',
        params => {
            format => "xml",
            rules => {
                applications => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                discoveryRules => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                graphs => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                groups => {
                    createMissing  => 'true'
                },
                images => {
                    createMissing  => 'true',
                    updateExisting => 'true'
                },
                items => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                maps => {
                    createMissing  => 'true',
                    updateExisting => 'true'
                },
                screens => {
                    createMissing  => 'true',
                    updateExisting => 'true'
                },
                templateLinkage => {
                    createMissing  => 'true'
                },
                templates => {
                    createMissing  => 'true',
                    updateExisting => 'true'
                },
                templateScreens => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                triggers => {
                    createMissing  => 'true',
                    updateExisting => 'true',
                    deleteMissing  => 'true'
                },
                valueMaps => {
                    createMissing  => 'true',
                    updateExisting => 'true'
                },
            },
            source => "$buff"
        },
        auth => "$authID",
        id   => 9,
     };
    $client->call($url, $json);
 };
}


