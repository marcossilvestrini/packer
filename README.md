![selec3a7c3a3o_111](https://user-images.githubusercontent.com/62715900/117728163-73868e00-b1bf-11eb-90c6-08f2a659576e.png)


## Getting Started

Fork the project and enjoy.
Atention for pre requisites and License!!!

## Prerequisites

Packer

## Authors

Marcos Silvestrini

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Oficial Doc

[Packer](https://www.packer.io/)
[Packer Docs](https://www.packer.io/docs)
[HCL2 Docs](https://www.packer.io/guides/hcl)
[Cloud Init Docs](https://cloudinit.readthedocs.io/en/latest/)

## Install Packer in Centos 7\8

```sh
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install packer
```

## Convert Json Template to HCL2

`packer hcl2_upgrade -with-annotations docker-ubuntu.json`

## Packer Files Extecion

```hcl2
.pkr.hcl
.pkr.json
```
