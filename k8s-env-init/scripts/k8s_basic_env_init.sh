# hostname
hostnamectl set-hostname 10.1.51.3

# 查看系统版本是否一致
cat /proc/version


# 设置时区为上海
timedatectl set-timezone Asia/Shanghai

# 关闭防火墙
systemctl disable firewalld --now

# 关闭SELinux
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# 安装ntp
yum -y install ntp
systemctl enable ntpd --now
systemctl status ntpd

# 关闭swapoff
swapoff -a
sed -i 's/^.*swap.*/#&/g' /etc/fstab
cat /etc/fstab