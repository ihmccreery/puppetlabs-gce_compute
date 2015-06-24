gce_instance { 'puppet-enterprise-master':
  ensure       => present,
  description  => 'A Puppet Enterprise Master and Console',
  zone         => 'us-central1-f',
  #machine_type => 'n1-standard-1',
  #network      => 'default',
  #tags         => ['puppet', 'pe-master'],
  startup_script       => 'puppet-enterprise.sh',
  block_for_startup_script => true,
  # stuff for autosigning
  puppet_module_repos      => {
    puppetlabs-gce_compute => "git://github.com/puppetlabs/\
puppetlabs-gce_compute"
  },
  puppet_manifest => '../examples/manifests/puppet_enterprise_master.pp',
  metadata             => {
    'pe_role'          => 'master',
    'pe_version'       => '3.3.1',
    'pe_consoleadmin'  => 'admin@example.com',
    'pe_consolepwd'    => 'puppetize',
  },
  scopes => ['compute-ro']
}

gce_instance { 'sample-agent':
  require        => Gce_instance['puppet-enterprise-master'],
  ensure         => present,
  zone           => 'us-central1-f',
  machine_type   => 'g1-small',
  network        => 'default',
  startup_script  => 'pe-simplified-agent.sh',
  block_for_startup_script => true,
  metadata       => {
    'pe_role'    => 'agent',
    'pe_master'  => 'puppet-enterprise-master',
    'pe_version' => '3.3.1',
  },
  tags           => ['puppet', 'pe-agent'],
}
