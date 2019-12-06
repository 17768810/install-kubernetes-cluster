# 安装所需工具

1. 规划好所有节点的hostname `hostname ; hostnamectl set-hostname xxxx` 不允许重复
2. 拷贝scripts文件到服务器
3. 设置执行权限
    ```sh
    chmod +x scripts/*
    ```
4. 执行 auto_install.sh（需要注意的是，用windows客户端的，sh传到服务器上时，可能会出现编码问题不能执行，需要执行下dos2unix sh文件，没有的yum install 安装一下）
    ```sh
    ./auto_install.sh
    ```
5. 推荐进行一次重启 `reboot`

## 环境验证
1. ulimit -a 确保允许打开的文件数够大
    > 持久化修改 /etc/security/limits.conf  
    > \*    soft    nofile    1024000  
    > \*    hard    nofile    1024000  
2. timedatectl status 确保时区为上海
3. free -h ; cat /etc/fstab 确保swap分区被注释
4. getenforce 确保SELinux关闭
5. systemctl status ntpd 确保nptd处于运行状态
6. sysctl -a | grep net.bridge.bridge-nf-call-ip 确保iptables和ip6tables为1