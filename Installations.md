```
sudo apt update -y && sudo apt upgrade -y && sudo apt install -y r10k openjdk-17-jre-headless && wget https://apt.puppetlabs.com/pool/bookworm/puppet8/p/puppet-agent/puppet-agent_8.9.0-1bookworm_arm64.deb && sudo dpkg -i puppet-agent_8.9.0-1bookworm_arm64.deb && wget https://apt.puppetlabs.com/pool/bookworm/puppet8/p/puppetserver/puppetserver_8.7.0-1bookworm_all.deb && dpkg -i puppetserver_8.7.0-1bookworm_all.deb
```

Following steps from https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent


```
ssh-keygen -t ed25519 -C "you@example.com" && cat ~/.ssh/id_ed25519.pub
```

Take the above and paste it into https://github.com/settings/ssh/new, then run this command
```
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && ssh -T git@github.com
```

```
sudo mkdir -p /etc/puppetlabs/r10k/ && sudo nano /etc/puppetlabs/r10k/r10k.yaml && chown -R puppet: /var/log/puppetlabs/ /etc/puppetlabs/ && r10k deploy environment -pv -c /etc/puppetlabs/r10k/r10k.yaml && sudo nano /etc/hosts && echo "input agent node name" && read agent_name && echo -e "[main]\ncertname = $agent_name\nserver = puppetserver.homelab.example\nenvironment = puppet_homelab_production\nruninterval = 5m\ndns_alt_names = puppetserver.homelab.example" >> /etc/puppetlabs/puppet/puppet.conf && sudo systemctl start puppetserver puppet && sudo systemctl enable puppetserver puppet && sudo systemctl status puppetserver puppet
```

```
---
sources:
  puppet_homelab:
    remote: 'git@github.com:YOUR_GITHUB_USER/puppet-homelab.git'
    basedir: '/etc/puppetlabs/code/environments/'
    prefix: true
```


###########################################

Installing agent 8.9.0 on debian 12 arm:

wget https://apt.puppet.com/pool/bookworm/puppet8/p/puppet-agent/puppet-agent_8.9.0-1bookworm_arm64.deb && sudo dpkg -i puppet-agent_8.9.0-1bookworm_arm64.deb && export PATH=$PATH:/opt/puppetlabs/bin/ && echo "input agent node name" && read agent_name && echo -e "[main]\ncertname = $agent_name\nserver = puppetserver.homelab.example\nenvironment = puppet_homelab_production\nruninterval = 5m" >> /etc/puppetlabs/puppet/puppet.conf && puppet agent -t




###########################################

Installing puppet agent on ubuntu 22.04 proxy node:

-1 Reverse ssh tunnel to puppet:
-- Download the private key for the cloud proxy host
-- Copy private key to puppetserver in /root/.ssh/proxy.key

-2 Setup puppet agent:

wget https://apt.puppet.com/pool/jammy/puppet8/p/puppet-agent/puppet-agent_8.9.0-1jammy_amd64.deb && sudo dpkg -i puppet-agent_8.9.0-1jammy_amd64.deb && export PATH=$PATH:/opt/puppetlabs/bin/ && echo "input agent node name" && read agent_name && echo -e "[main]\ncertname = $agent_name\nserver = puppetserver.homelab.example\nenvironment = puppet_homelab_production\nruninterval = 5m\nserverport = 8141" >> /etc/puppetlabs/puppet/puppet.conf && echo -e "127.0.0.1\tpuppetserver.homelab.example" >> /etc/hosts && puppet agent -t
