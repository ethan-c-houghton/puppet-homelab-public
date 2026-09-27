```
   __    __   ______   __       __  ________  __         ______   _______  
  |  \  |  \ /      \ |  \     /  \|        \|  \       /      \ |       \ 
  | $$  | $$|  $$$$$$\| $$\   /  $$| $$$$$$$$| $$      |  $$$$$$\| $$$$$$$\
  | $$__| $$| $$  | $$| $$$\ /  $$$| $$__    | $$      | $$__| $$| $$__/ $$
  | $$    $$| $$  | $$| $$$$\  $$$$| $$  \   | $$      | $$    $$| $$    $$
  | $$$$$$$$| $$  | $$| $$\$$ $$ $$| $$$$$   | $$      | $$$$$$$$| $$$$$$$\
  | $$  | $$| $$__/ $$| $$ \$$$| $$| $$_____ | $$_____ | $$  | $$| $$__/ $$
  | $$  | $$ \$$    $$| $$  \$ | $$| $$     \| $$     \| $$  | $$| $$    $$
   \$$   \$$  \$$$$$$  \$$      \$$ \$$$$$$$$ \$$$$$$$$ \$$   \$$ \$$$$$$$ 
```
---

# puppet-homelab

Puppet control repo for a small homelab: Raspberry Pis, a Proxmox host, PuppetDB and two cloud
proxy nodes that reach the Puppet server through reverse SSH tunnels (autossh) and nginx stream
proxies. Environments are deployed with r10k; secrets live in hiera-eyaml.

## Layout

| Path | Purpose |
|---|---|
| `manifests/site.pp` | Profiles (`profile::base`, `profile::raspberry_pi`) and node classification |
| `data/common.yaml` | Shared Hiera data: accounts, oh-my-zsh, default packages, agent config |
| `data/nodes/*.yaml` | Per-node Hiera data |
| `data/secrets/*.eyaml` | Encrypted per-node secrets (hiera-eyaml, PKCS7) |
| `lib/puppet/functions/` | Small custom functions |
| `Puppetfile` | Forge and git modules for r10k |
| `Installations.md` | Bootstrap notes for the server and agents |

## Using it

This is a sanitized copy. Before it will run, replace the placeholders:

- `homelab.example`: your own domain.
- `YOUR_GITHUB_USER`: where your control repo and the `default_packages` and `autossh`
  modules live (those two modules are not included here).
- `REPLACE_WITH_SHA512_CRYPT_HASH`: generate with `mkpasswd -m sha-512`.
- `AAAA_REPLACE_WITH_...`: your SSH public keys.
- `ENC[PKCS7,REPLACE_WITH_EYAML_ENCRYPTED_VALUE]`: encrypt your own values with
  `eyaml encrypt -s '<value>'` using your own PKCS7 keys.
