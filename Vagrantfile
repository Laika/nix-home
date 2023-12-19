# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.require_version '>= 2.2.0'

host = RbConfig::CONFIG['host_os']

$mem = if host =~ /darwin/
         `sysctl -n hw.memsize`.to_i / 1024 / 1024
       elsif host =~ /linux/
         `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024
       else
         `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024
       end
$mem = [$mem / 2, 4096].max

$cpus = ENV.fetch('VIRTENV_CPUS', `nproc`.to_i / 4)
$mem = ENV.fetch('VIRTENV_MEMORY', $mem)
$hostname = ENV.fetch('VIRTENV_HOSTNAME', 'ctf')
$vagrant_box = ENV.fetch('VIRTENV_VAGRANT_BOX', 'ubuntu/jammy64')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Base
  config.vm.box = $vagrant_box
  config.vm.box_check_update = true
  config.vm.hostname = $hostname

  # Network
  config.vm.network 'private_network', ip: '192.168.56.100'

  # File system
  config.vm.synced_folder './share', '/share',
                          create: true, owner: 'vagrant', group: 'vagrant'

  # Specification
  config.disksize.size = '80GB'
  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = $cpus
    vb.memory = $mem
  end

  # SSH
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
end

