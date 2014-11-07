
### TODO (CentOS 7)

- [x] CentOS 7 をインストール
- [x] `yum install yum-fastestmirror` と `yum update` を実行
- [x] `yum-cron` をインストールし`/etc/yum/yum-cron.conf` を設定
- [x] `/etc/aliases` に `root: foobar@mailaddr` を追加し root のメールアドレスを設定
- [x] `/etc/hosts.deny` の設定。`sshd : all` とする
- [x] `/etc/hosts.allow` の設定。`sshd : 192.168.` などと設定
- [x] root でない一般ユーザを作成
- [x] `/etc/ssh/sshd_config` を編集。rootログインとパスワードログインなどを禁止する
- [x] SSH接続用の公開鍵と秘密鍵を設定
- [x] Firewall の設定。`firewall-cmd` を使う。
- [x] 静的IPの設定。`/etc/sysconfig/network-scripts/ifcfg-enp9s0` を編集。`enp9s0` の部分は環境によって変化する
- [x] `/etc/sysctl.conf` の設定。`vsp-infra/sysctl.conf` 参照。
- [x] nginx の設定。`/etc/nginx/nginx.conf` を `vsp-infra/nginx.conf` で置き換え
- [x] `/etc/nginx/html` に `index.html` などを配置
- [x] nginx が自動起動するように設定
- [x] SELinux が nginx の動作を妨げていないか確認。`error.log` などを参照
- [x] サスペンドを無効にする。`/etc/systemd/logind.conf` を編集
- [x] `/root` に dropbox をインストール。`/etc/systemd/system/` に `dropbox.service` を配置し `systemctl enable dropbox` を実行する

### 参照
- [CentOS7初期設定](http://centossrv.com/centos7-init.shtml)
- [Top 20 Nginx WebServer Best Security Practices](http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html)
- [RedmineをCentOS_7上で動かすーUnicornとNginx編](http://www.torutk.com/projects/swe/wiki/RedmineをCentOS 7上で動かすーUnicornとNginx編)
