define doyeoman::base (

  # class arguments
  # ---------------
  # setup defaults

  $user = 'web',
  $app_port = 3000,
  $app_name = 'helloyo',
  $app_command = 'angular helloangular',

  # install directory
  $target_dir = '/var/www/html',
 
  # create symlink and if so, where
  $symlinkdir = false,

  # end of class arguments
  # ----------------------
  # begin class

) {

  # @todo complete when yo --silent available
  # this has not been completed because yo requires too much command-line input and has no --silent flag

  # make the app's directory
  file { "doyeoman-base-makedir-${title}" :
    path => "{$target_dir}/${app_name}",
    ensure => 'directory',
  }->

  # run yeoman inside that directory
  exec { "doyeoman-base-create-${title}" :
    path => '/bin:/usr/bin:/sbin:/usr/sbin',
    command => "yo ${app_command}",
    user => $user,
    cwd => "/home/${user}",
  }

  # create symlink from our home folder
  if ($symlinkdir) {
    # create symlink from directory to repo (e.g. user's home folder)
    file { "${symlinkdir}/${app_name}" :
      ensure => 'link',
      target => "${target_dir}/${app_name}",
      require => [Exec["doyeoman-base-create-${title}"]],
    }
  }
  
}
