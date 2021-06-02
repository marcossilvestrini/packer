# Learning Packer

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

[Packer](https://www.packer.io/)\
[Packer Docs](https://www.packer.io/docs)\
[HCL2 Docs](https://www.packer.io/guides/hcl)\
[Cloud Init Docs](https://cloudinit.readthedocs.io/en/latest/)
[Kickstart Centos](https://gainanov.pro/eng-blog/linux/centos-installation-with-kickstart/)
[Kickstart Configurator Oracle Linux](https://oracle-base.com/articles/linux/kickstart)
[Install Kickstart Configurator Centos](https://linuxhint.com/install-centos-kickstart/)

## Install Packer in Centos 7\8

```sh
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install packer
```

## Convert Json Template to HCL2

`packer hcl2_upgrade -with-annotations docker-ubuntu.json`

## Packer Files Extencion

```hcl2
.pkr.hcl
.pkr.json
```

## Blocks

### [Block Build](https://www.packer.io/docs/templates/hcl_templates/blocks/build)

```hcl2
# build.pkr.hcl
build {
    # use the `name` field to name a build in the logs.
    # For example this present config will display
    # "buildname.amazon-ebs.example-1" and "buildname.amazon-ebs.example-2"
    name = "buildname"

    sources = [
        # use the optional plural `sources` list to simply use a `source`
        # without changing any field.
        "source.amazon-ebs.example-1",
    ]

    source "source.amazon-ebs.example-2" {
        # Use the singular `source` block set specific fields.
        # Note that fields cannot be overwritten, in other words, you cannot
        # set the 'output' field from the top-level source block and here.
        output = "different value"
        name = var.foo
    }

    provisioner "shell" {
        scripts = fileset(".", "scripts/{install,secure}.sh")
    }

    post-processor "shell-local" {
        inline = ["echo Hello World from ${source.type}.${source.name}"]
    }
}
```

### [Block Locals](https://www.packer.io/docs/templates/hcl_templates/blocks/locals)

```hcl2
# locals.pkr.hcl
locals {
    # locals can be bare values like:
    wee = local.baz
    # locals can also be set with other variables :
    baz = "Foo is '${var.foo}' but not '${local.wee}'"
}

# Use the singular local block if you need to mark a local as sensitive
local "mylocal" {
  expression = "${var.secret_api_key}"
  sensitive  = true
}
```

### [Block Source](https://www.packer.io/docs/templates/hcl_templates/blocks/source)

```hcl2
sources.pkr.hcl
source "amazon-ebs" "example-1" {
    // ...
}
```

### [Block Variable](https://www.packer.io/docs/templates/hcl_templates/blocks/variable)

```hcl2
# variables.pkr.hcl
variable "foo" {
    type        = string
    default     = "the default value of the `foo` variable"
    description = "description of the `foo` variable"
    sensitive   = false
    # When a variable is sensitive all string-values from that variable will be
    # obfuscated from Packer's output.
}
```

### [Block Data](https://www.packer.io/docs/templates/hcl_templates/blocks/data)

```hcl2
# datasource.pkr.hcl
data "amazon-ami" "basic-example" {
  // ...
}
```
