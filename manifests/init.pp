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

}
