# This class will install the syslinux images into the tftp root directory.

class pxe::syslinux {

  include pxe::params

  $syslinux_dir     = $pxe::params::syslinux_dir
  $syslinux_archive = $pxe::params::syslinux_archive
  $tftp_root        = $pxe::tftp_root

  exec { 'syslinux_install':
    path    => ['/bin', '/usr/bin', '/usr/local/bin'],
    cwd     => '/usr/local/src',
    command => "wget -q -O - ${syslinux_archive} | tar -xzf - -C `dirname ${syslinux_dir}`",
    creates => $syslinux_dir,
  }

  File {
    owner   => root,
    group   => 0,
    mode    => '0755',
    require => File[$tftp_root],
  }

  file { $tftp_root:
    ensure  => directory,
    require => undef,
  }

  file { "${tftp_root}/syslinux":
    ensure => directory,
  }

  file { "${tftp_root}/pxelinux.0":
    source  => "${syslinux_dir}/bios/core/pxelinux.0",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi32/syslinux32.efi":
    source  => "${syslinux_dir}/efi32/efi/syslinux.efi",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi32/ldlinux.e32":
    source  => "${syslinux_dir}/efi32/com32/elflink/ldlinux/ldlinux.e32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi32/menu.c32":
    source  => "${syslinux_dir}/efi32/com32/menu/menu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi32/libutil.c32":
    source  => "${syslinux_dir}/efi32/com32/libutil/libutil.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi64/syslinux64.efi":
    source  => "${syslinux_dir}/efi64/efi/syslinux.efi",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi64/ldlinux.e64":
    source  => "${syslinux_dir}/efi64/com32/elflink/ldlinux/ldlinux.e64",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi64/menu.c32":
    source  => "${syslinux_dir}/efi64/com32/menu/menu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/efi64/libutil.c32":
    source  => "${syslinux_dir}/efi64/com32/libutil/libutil.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/menu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/menu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/vesamenu.c32":
    source  => "${syslinux_dir}/bios/com32/menu/vesamenu.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/reboot.c32":
    source  => "${syslinux_dir}/bios/com32/modules/reboot.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/ldlinux.c32":
    source  => "${syslinux_dir}/bios/com32/elflink/ldlinux/ldlinux.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/libcom32.c32":
    source  => "${syslinux_dir}/bios/com32/lib/libcom32.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/libutil.c32":
    source  => "${syslinux_dir}/bios/com32/libutil/libutil.c32",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/syslinux/memdisk":
    source  => "${syslinux_dir}/bios/memdisk/memdisk",
    require => Exec['syslinux_install'],
  }

  file { "${tftp_root}/pxelinux.cfg":
    ensure => directory,
  }

  file { "${tftp_root}/efi32":
    ensure => directory,
  }

  file { "${tftp_root}/efi64":
    ensure => directory,
  }
}
