gce_instance { 'puppet-enterprise-master':
  require => Gce_instance['sample-agent'],
  ensure       => absent,
  zone         => 'us-central1-f'
}

gce_instance { 'sample-agent':
  ensure         => absent,
  zone           => 'us-central1-f',
}
