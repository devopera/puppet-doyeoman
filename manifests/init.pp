class doyeoman (

  # class arguments
  # ---------------
  # setup defaults

  $user = 'web',

  # end of class arguments
  # ----------------------
  # begin class

) {

  if ! defined(Package['yo']) {
    package { 'yo' :
      provider => 'npm',
    }
  }
  if ! defined(Package['generator-webapp']) {
    package { 'generator-webapp' :
      provider => 'npm',
      require => [Package['yo']],
    }
  }
  # install angular deps
  if ! defined(Package['generator-angular']) {
    exec { 'doyeoman-install-angular-deps' :
      path => '/bin:/usr/bin:/sbin:/usr/sbin',
      command => 'npm install -g grunt-cli grunt-karma karma-jasmine --save-dev',
      require => [Package['yo']],
    }->
    package { 'generator-angular' :
      provider => 'npm',
      require => [Package['yo']],
    }
  }

}
