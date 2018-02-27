#!/usr/bin/bash
sudo apt-get update -y
sudo apt-get install wget git -y -q -o Dpkg::Options::="--force-confold" --no-install-recommends cpio libdapl2 libmlx4-1 libsm6 libxext6

# install intel MPI
cd /tmp
sudo wget -q 'http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/11595/l_mpi_2017.3.196.tgz'
tar zxvf l_mpi_2017.3.196.tgz
sed -i -e 's/^ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' /tmp/l_mpi_2017.3.196/silent.cfg
sed -i -e 's|^#ACTIVATION_LICENSE_FILE=|ACTIVATION_LICENSE_FILE=/tmp/l_mpi_2017.3.196/USE_SERVER.lic|g' /tmp/l_mpi_2017.3.196/silent.cfg
sed -i -e 's/^ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=license_server/g' /tmp/l_mpi_2017.3.196/silent.cfg
cd /tmp/l_mpi_2017.3.196
./install.sh -s silent.cfg
cd ..
rm -rf l_mpi_2017.3.196*
echo "source /opt/intel/compilers_and_libraries_2017.4.196/linux/mpi/intel64/bin/mpivars.sh" >> ~/.bashrc

# install horovod
source /opt/intel/compilers_and_libraries_2017.4.196/linux/mpi/intel64/bin/mpivars.sh
pip install horovod

# install other dependencies
pip install fix_yahoo_finance keras pandas-datareader