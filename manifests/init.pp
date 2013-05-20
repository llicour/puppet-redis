class redis( $up = true ) {

    include yum::epel

    package { 'redis' :
        ensure  => present,
        require => File[ 'epel.repo' ],
    }

    file { 'redis.conf' :
        ensure  => present,
        path    => '/etc/redis.conf',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/redis/redis.conf',
        notify  => Service["redis"],
    }

    service { 'redis' :
        ensure  => $up? { true    => running,
                          'true'  => running,
                          default => stopped },
        enable  => $up? { true    => true,
                          'true'  => true,
                          default => false   },
        require => Package[ 'redis' ],
    }

}
