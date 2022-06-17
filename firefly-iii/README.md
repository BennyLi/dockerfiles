# Firefly III 🐷 - Docker Compose Project 🐋

This Docker Compose project will setup a Firefly III instance, including the Maria DB backend, a Redis cache and Traefik integration.

## ⚠ READ THIS CAREFULLY ⚠

This Docker Compose project is part of my distributed Ansible workflow and will not work easily on it's own.
Please take a look at the [Ansible Playbook Skeleton](https://github.com/BennyLi/ansible-playbook-skeleton) repository to get more information on this.
The related Ansible role can be found [here](https://github.com/BennyLi/ansible-roles/tree/main/firefly-iii).

## Where are the config files? 🔍

- The `.env` and `firefly.traefik.yml` files can be found in my [.dotfiles](https://github.com/BennyLi/dotfiles/tree/main/firefly-iii) repo.

