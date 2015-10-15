#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with unifiedlogs](#setup)
    * [What unifiedlogs affects](#what-unifiedlogs-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with unifiedlogs](#beginning-with-unifiedlogs)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module allows centrally sshfs-mounting of specific directories using Puppet exported resources.

## Module Description

The module use sshfs userspace filesystem to mount via ssh directories from other nodes. The list of directories and nodes is mantained using Puppet exported resources.

I built this module to solve the problem of unified access to application logs via one single point. This module can be mixed with NFS or SAMBA to provide network based unified logs access.

## Setup

### What unifiedlogs affects

* The unifiedlogs class will install sshfs on your system and configure sshfs mounts as puppet services.
* The logs are not copied on the centralized system: the logs are only made available on the centralized system!!! If the application node dies, the logs will be unavailable.

### Setup Requirements

Since the module is using exported resources it needs storeconfig enabled.

### Beginning with unifiedlogs

On your application server nodes declare the unifiedlogs::exported class:

class { '::unifiedlogs::exported':
    dir   => "/logs",
    user  => "root",
    label => "LABEL", 
}

This has the effect of declaring an exported unifiedlogs::sshfsmount resource for directory "/logs" and user root (the user used for ssh access from the central server).

The label parameter is used to restrict the resource collection on the centralized logs server.

On the centralized logs server, include or declare the unifiedlogs class:

include ::unifiedlogs

or 

class { '::unifiedlogs':
        hookdir => "/mnt",
        label   => "LABEL",
}

hookdir is the top directory where the sshfs mounts are created.

## Usage

Class unifiedlogs has three params: hookdir, label and package_name (the second is required only if the module is used on a Linux distribution different from Debian/Ubuntu or RHEL/Centos).

Class unifiedlogs::exported has dir, label and user parameters explained above.


## Reference

Defined types:

  * sshfsmount - the main code, it deals with creation of ssfhs mount service and of mount directory

Classes:
  
  * unifiedlogs - called on centralized log server
  * unifiedlogs::install - installs ssfhs package
  * unifiedlogs::service - collect the exported resources
  * unifiedlogs::exported - define the exported resources 
  * unifiedlogs::params - default parameters

## Limitations

Right now it is possible to export only one dir per node.

## Development

Fork and contribute via PR.

## Release Notes/Contributors/Etc **Optional**

First version, some bugs may exist.
