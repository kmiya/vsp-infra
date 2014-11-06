# ref: https://github.com/TalkingQuickly/docker_rails_dev_env/
# ref: https://github.com/coreos/coreos-vagrant/

Vagrant.require_version ">= 1.6.0"

$setup = <<SCRIPT

# Stop and remove any existing containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Run and link the containers
docker run -d --name web-nginx -p 80:80 -p 22:22 \
  -v /web/html:/etc/nginx/html:ro \
  -v /web/nginx.conf:/etc/nginx/nginx.conf:ro \
  web-nginx:latest

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
docker start web-nginx
SCRIPT

# Defaults for config options
$num_instances = 1
$update_channel = "alpha"
$enable_serial_logging = false
$vb_gui = false
$vb_memory = 1024
$vb_cpus = 1

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "coreos-%s" % $update_channel
  config.vm.box_version = ">= 308.0.1"
  config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $update_channel

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant_vmware_fusion.json" % $update_channel
  end

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.define vm_name = "core-01"
  config.vm.hostname = vm_name
  config.vm.synced_folder ".", "/web", id: "core", type: "rsync", rsync__exclude: ".git/"
  
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  
  config.vm.provider "virtualbox" do |vb|
    vb.gui = $vb_gui
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
#    vb.customize ["modifyvm", :id, "--ostype", "Other_64"]
  end
  
  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start
 
 end