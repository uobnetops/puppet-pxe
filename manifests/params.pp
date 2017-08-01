# Class: pxe::params
#
# Some static variables to use elsewhere
#
class pxe::params {

  $syslinux_archive = 'https://www.kernel.org/pub/linux/utils/boot/syslinux/Testing/6.04/syslinux-6.04-pre1.tar.gz'
  $syslinux_dir     = '/usr/local/src/syslinux-6.04-pre1'
}
