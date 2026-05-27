#!/bin/sh
sed -i.bak 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i.bak 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum install -y epel-release vim curl wget net-tools telnet
yum update -y
firewall-cmd --zone=public --add-port=943/tcp --permanent
firewall-cmd --zone=public --add-port=943/udp --permanent
firewall-cmd --zone=public --add-port=1194/tcp --permanent
firewall-cmd --zone=public --add-port=1194/udp --permanent
firewall-cmd --reload
sudo yum install centos-release-scl-rh -y
sudo yum install rh-python38 rh-python38-python-lxml rh-python38-python-pycparser rh-python38-python-idna rh-python38-python-cryptography -y
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/sysconfig/selinux
sysctl net.ipv4.ip_forward
sysctl -w net.ipv4.ip_forward=1
yum install https://as-repository.openvpn.net/as-repo-centos7.rpm -y
sed -i.bak 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i.bak 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum install openvpn-as -y
wget https://openvpn.net/downloads/openvpn-as-latest-CentOS7.x86_64.rpm
wget https://openvpn.net/downloads/openvpn-as-bundled-clients-latest.rpm
yum install -y openvpn-as-* -y
systemctl start openvpnas
systemctl status openvpnas
sudo /usr/local/openvpn_as/scripts/sacli UserPropGet
sudo /usr/local/openvpn_as/scripts/sacli --user openvpn --new_pass=123456 SetLocalPassword
echo "=========================CHANGE PASSWORD SUCCESS=============================="
sudo systemctl restart openvpnas
yum install -y python3 unzip zip
ls -alh /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg
mkdir -p /root/openvpnas/compile && cd $_
cp /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg .
unzip -q ./pyovpn-2.0-py3.8.egg
cd ./pyovpn/lic/
mv uprop.pyc uprop2.pyc
echo
cat >uprop.py<<EOF
from pyovpn.lic import uprop2
old_figure = None

def new_figure(self, licdict):
    ret = old_figure(self, licdict)
    ret['concurrent_connections'] = 3979
    return ret

for x in dir(uprop2):
    if x[:2] == '__':
        continue
    if x == 'UsageProperties':
        exec('old_figure = uprop2.UsageProperties.figure')
        exec('uprop2.UsageProperties.figure = new_figure')
    exec('%s = uprop2.%s' % (x, x))
EOF
cat uprop.py
echo
python3 -O -m compileall uprop.py && mv __pycache__/uprop.*.pyc uprop.pyc
cd ../../
zip -rq pyovpn-2.0-py3.8.egg.cracked_2.12.0 ./pyovpn ./EGG-INFO ./common
mv /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg.orginal
cp ./pyovpn-2.0-py3.8.egg.cracked_2.12.0 /usr/local/openvpn_as/lib/python/pyovpn-2.0-py3.8.egg
systemctl restart openvpnas
systemctl status openvpnas
echo "ACCOUNT!! USER:openvpn - PASSWORD: 123456"
echo "=========================SETUP UNLIMITED OPENVPN 2.13.1 SUCCESS=============================="
cd
