# windows通过密钥SSH登陆Linux

##### 概述

客户端通过密钥SSh登陆Linux的条件：

- 服务器端登陆账户home目录下的.ssh文件夹存在公钥，命名authorized_keys
- 客户端拥有与公钥配对的私钥
  下面以win 10通过自带的OpenSSH客户端以密钥方式登陆Ubuntu为例进行说明

##### 操作

1. 生成密钥对

   ```shell
   student@vagrant-ubuntu-trusty-64:~$ssh-keygen
   Generating public/private rsa key pair.
   Enter file in which to save the key (/home/student/.ssh/id_rsa):这里按enter默认或另外写路径和文件名
   Enter passphrase (empty for no passphrase):是否给私密再加一次密，无需则不填
   Enter same passphrase again:由于我有设置，这里需要再输入一次密码
   Your identification has been saved in /home/student/.ssh/id_rsa.
   Your public key has been saved in /home/student/.ssh/id_rsa.pub.
   The key fingerprint is:
   78:ad:4c:7e:cc:a4:9b:ac:34:50:4c:59:c8:ff:60:a1 student@vagrant-ubuntu-trusty-64
   The key's randomart image is:
   +--[ RSA 2048]----+
   |     ..+.        |
   |     o+ .        |
   |      oo .       |
   |     .E.+.       |
   |    . ..Soo      |
   |     . = *.      |
   |      o = +      |
   |     . o +       |
   |      ..+        |
   +-----------------+
   ```

2. 配置公钥

   ```shell
   # 查看密钥对是否生成
   student@vagrant-ubuntu-trusty-64:~$ ls .ssh
   id_rsa  id_rsa.pub
   # 将公钥放置在 authorized_keys 中
   student@vagrant-ubuntu-trusty-64:~$ cat .ssh/id_rsa.pub >> .ssh/authorized_keys
   # 设置权限
   student@vagrant-ubuntu-trusty-64:~$ chmod 600 .ssh/authorized_keys
   student@vagrant-ubuntu-trusty-64:~$ chmod 700 .ssh
   ```

   >   上面将公钥放置在 authorized_keys中的步骤用到了输出重定向，如果不嫌麻烦可以用mkdir .ssh和touch .ssh/authorized_keys手动创建，然后cat出id_rsa.pub的内容，用vim或nano将其复制到authorized_keys中。

3. 下载私钥到客户端

   - 手工操作方式：本地新建一个文本文件，将上述id_rsa中内容复制进去

   - 通过scp命令复制：

     ```shell
     PS C:\Users\XXX> scp -P 2222 student@127.0.0.1:/home/student/.ssh/id_rsa D:\key
     student@127.0.0.1's password: 这里输入密码
     id_rsa   100% 1766     1.7KB/s   00:00
     ```

   >   上述命令加入了端口号，一般默认22，不用加

4. 通过密钥登陆

   ```shell
   PS C:\Users\xxx> ssh student@127.0.0.1 -p 2222 -i D:\id_rsa
   Enter passphrase for key 'D:\id_rsa': 这里输入密钥保护密码
   Welcome to Ubuntu 14.04.6 LTS (GNU/Linux 3.13.0-167-generic x86_64)
   ……
   ```

   >  登陆成功！这里只输入了密钥保护密码，而不用再输入账号本身的口令，如果之前设置不用给密钥再加密，这里可直接登陆

   