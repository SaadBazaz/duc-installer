cp noip2.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable noip2
systemctl start noip2
