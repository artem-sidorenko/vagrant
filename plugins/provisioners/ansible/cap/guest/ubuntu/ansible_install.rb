require_relative "../debian/ansible_install"

module VagrantPlugins
  module Ansible
    module Cap
      module Guest
        module Ubuntu
          module AnsibleInstall

            def self.ansible_install(machine, install_mode, ansible_version)
              if install_mode == :pip
                Debian::AnsibleInstall::ansible_pip_install machine, ansible_version
              else
                ansible_apt_install machine
              end
            end

            private

            def self.ansible_apt_install(machine)
              machine.communicate.sudo "apt-get update -y -qq"
              machine.communicate.sudo "apt-get install -y -qq software-properties-common python-software-properties"
              machine.communicate.sudo "add-apt-repository ppa:ansible/ansible -y"
              machine.communicate.sudo "apt-get update -y -qq"
              machine.communicate.sudo "apt-get install -y -qq ansible"
            end

          end
        end
      end
    end
  end
end
