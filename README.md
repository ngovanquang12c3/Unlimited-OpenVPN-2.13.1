#!/bin/sh
# Install Open VPN 2.13.1 treen Centos 7
CÁCH 1: LỆNH NÀY SẼ TỰ CHẠY 
sed -i.bak 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i.bak 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
cd /tmp/ && yum install git -y && git clone https://github.com/income88/Unlimited-OpenVPN-2.13.1 && cd Unlimited-OpenVPN-2.13.1/ && sed -i -e 's/\r$//' openvpn_2_13_1.sh && chmod 755 openvpn_2_13_1.sh && ./openvpn_2_13_1.sh

CÁCH 2: 
FIX LỖI Could not retrieve mirrorlist
sed -i.bak 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i.bak 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum install wget -y
wget https://github.com/income88/Unlimited-OpenVPN-2.13.1/openvpn_2_13_1.sh && sudo sh openvpn_2_13_1.sh

..................................
CÁCH SAO LƯU DỮ LIỆU TỪ SERVER CŨ
# CÁCH 1: CHỈ SAO LƯU USER
# TRÊN SERVER CŨ
scp /usr/local/openvpn_as/etc/db/* root@172.27.105.23:/usr/local/openvpn_as/etc/db/   
"Thay IP Server mới cho đúng"

.......................................
#CÁCH 2: SAO LƯU TẤT CẢ (KỂ CẢ LISENCE)
Dùng FileZilla để tạo đường dẫn: /path/to/backup/ cho Server Open VPN cần chuyển tới sau đó:

# Bước 1: Sao lưu dữ liệu từ server cũ
sudo systemctl stop openvpnas
sudo tar czvf openvpn_as_backup.tar.gz /usr/local/openvpn_as/
scp openvpn_as_backup.tar.gz root@172.27.105.31:/path/to/backup/    ----Thay TK root và IP server cần chuyển

# Bước 2: Phục hồi dữ liệu trên server mới
Cài đặt OpenVPN Access Server trên server mới: Trên server mới, cài đặt phiên bản OpenVPN Access Server cùng phiên bản với server cũ (phiên bản 2.14.1). Bạn có thể làm theo các hướng dẫn cài đặt chính thức của OpenVPN Access Server.
sudo systemctl stop openvpnas
sudo tar xzvf /path/to/backup/openvpn_as_backup.tar.gz -C /
sudo chown -R openvpn:openvpn /usr/local/openvpn_as
sudo systemctl start openvpnas
sudo systemctl status openvpnas

# Bước 3: Kiểm tra và cấu hình lại
Kiểm tra tường lửa và các quy tắc bảo mật trên server mới để đảm bảo rằng các cổng cần thiết (ví dụ: 1194, 443) được mở.
Sau khi hoàn tất, server OpenVPN mới của bạn sẽ hoạt động giống như server cũ với tất cả các cấu hình và dữ liệu người dùng đã được chuyển.
