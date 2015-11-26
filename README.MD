vagrant-hadoop-cluster
======================

Deploying hadoop in a virtualized cluster in simple steps.

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Git clone this project, and change directory (cd) into this project (directory).
4. Run ```vagrant up``` to create the VM.
5. Run ```vagrant ssh``` to get into your VM.
6. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.

# Make the VMs setup faster
You can make the VM setup even faster if you pre-download the Hadoop, Spark, and Oracle JDK into the /resources directory.

The setup script will automatically detect if these files (with precisely the same names) exist and use them instead. If you are using slightly different versions, you will have to modify the script accordingly.
