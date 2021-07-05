#!/bin/sh

cat <<-EOF > /root/cloudreve/conf.ini
[System]
; 运行模式
Mode = master
; 监听端口
Listen = :${PORT}
; 是否开启 Debug
Debug = false
; Session 密钥, 一般在首次启动时自动生成
SessionSecret = oXIYVNP23Z9cXRCqn8C8z8etztNo5E33Qd6n6q3TFe3Z7aPPSer4nOEmADwljdIh
; Hash 加盐, 一般在首次启动时自动生成
HashIDSalt = 2je20slhtLqQXalz7a0mCA9hU0H88B0D7vy3jiW4Zw97z35VBeglaFuDBEwmNma9

[Redis]
Server = 127.0.0.1:6379
Password =
DB = 0

[Database]
; 数据库类型，目前支持 sqlite | mysql
Type = mysql
; 数据库地址
Host = 52.230.80.79
; MySQL 端口
Port = 3306
; 用户名
User = abcd
; 密码
Password = ZkdzPpC4xke62Emh
; 数据库名称
Name = abcd
; 数据表前缀
TablePrefix = V3
EOF

trackerlist=`wget -qO- https://trackerslist.com/all.txt |awk NF|sed ":a;N;s/\n/,/g;ta"`
sed -i '$a bt-tracker='${trackerlist} /root/aria2/aria2.conf
nohup aria2c --conf-path=/root/aria2/aria2.conf  &

redis-server --appendonly yes --daemonize yes
/root/cloudreve/cloudreve -c /root/cloudreve/conf.ini
