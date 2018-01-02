# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "vagrant-eval-win7x64-enterprise"
  config.vm.box = "eval-win7x64-enterprise"

  # Port forward WinRM and RDP
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct:true
  config.vm.communicator = "winrm"
  config.vm.guest = :windows
  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct:true
  # Port forward SSH
  #config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct:true

  config.vm.provider :virtualbox do |v, override|
    v.gui = true
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 1]
    v.customize ["modifyvm", :id, "--vram", "256"]
    v.customize ["setextradata", "global", "GUI/MaxGuestResolution", "any"]
    v.customize ["setextradata", :id, "CustomVideoMode1", "1024x768x32"]

    config.trigger.before :destroy do
      id_file = ".vagrant/machines/default/virtualbox/id"
      machine_id = File.read(id_file) if File.exist?(id_file)
      if !machine_id.nil?
        pid = `ps -ax | grep #{machine_id} | grep -v grep | cut -d ' ' -f 1`
        if pid =~ /\d+/
          info "Killing #{machine_id} with pid #{pid}"
          run "kill -9 #{pid}"
        end
      end
    end
  end

  ["vmware_fusion", "vmware_workstation"].each do |provider|
    config.vm.provider provider do |v, override|
      v.gui = true
      v.linked_clone = true
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
      v.vmx["cpuid.coresPerSocket"] = "1"
      v.vmx["ethernet0.virtualDev"] = "vmxnet3"
      v.vmx["RemoteDisplay.vnc.enabled"] = "false"
      v.vmx["RemoteDisplay.vnc.port"] = "5900"
      v.vmx["scsi0.virtualDev"] = "lsilogic"
    end
  end

  config.vm.provider :parallels do |v, override|
    v.customize ["set", :id, "--cpus", 1]
    v.customize ["set", :id, "--memsize", 2048]
    v.customize ["set", :id, "--videosize", "256"]
  end
end
