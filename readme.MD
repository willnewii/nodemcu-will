### 工具

- [ESPlorer IDE](https://esp8266.ru/esplorer/)
- [CP210x 驱动](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers)
- [构建固件](https://nodemcu-build.com/)
- [刷机工具-nodemcu-flasher](https://github.com/nodemcu/nodemcu-flasher)
- [刷机工具-nodemcu-pyflasher](https://github.com/marcelstoer/nodemcu-pyflasher)

### 准备工作
1. 根据nodemcu板子来安装驱动,有ch340g/cp210x之分,注意看一下自己的板子
2. 构建固件.你可以在网站上选择自己需要的模块,然后进行构建.几分钟后,就会发到你的邮箱里.
3. 刷固件,有两个工具.flasher已经很久没有更新了.就想着用pyflasher,但是在我的PC上出现了 Hard Resting... 然后卡死了. flasher反而能成功刷入.
4. 成功刷好后,打开ESPlorer.选择对应的端口,点击open.然后！！！**记得按一下板子上的复位键**,这样就链接成功了.ESPlorer有一些snippets,你可以通过点击  ‘chip Info’ 等看看是否能正常返回


### tips
- AP: 192.168.4.1

### util
- gpio      基本的控制板载led
- uart      GPIO3  通过串口读取plantower Sensor 的数据
- websocket 基本的websocket链接用例
- httpServer 通过http设置wifi


### 其它
- [NodeMCU-HTTP-Server](https://github.com/wangzexi/NodeMCU-HTTP-Server)

### 参考资料
- [lua教程](http://www.runoob.com/lua/lua-tutorial.html)
- [nodemcu文档](https://nodemcu.readthedocs.io/en/master/)

### esp8266 刷机
![阵脚连接](http://obfmtiyt5.bkt.clouddn.com/img/819239-20170103234531081-897735531.png)
GPIO0　默认是工作模式（不接线）。如果接了低电平就是下载模式（给模块刷固件！！）所以接低电平。CH_PD接高电平,其余除了TX,RX外可以不接线..

- 复位:CH_PD引脚的3.3V电源断了重接进行复位

### 
```shell
# 
esptool.py -p /dev/tty.wchusbserial1420 flash_id
# 删除
esptool.py -p /dev/tty.wchusbserial1420 erase_flash
# 刷机
esptool.py -p /dev/tty.wchusbserial1420 write_flash 0x0 xxx.bin
```

### [McuNode](http://eiot.club/)
#### server 构建
```shell
# 下载go
# https://www.golangtc.com/download

# 配置环境变量  GOROOT(go目录) PATH(bin目录) GOPATH(项目目录)
# http://blog.csdn.net/chenggong2dm/article/details/49364691

# 下载项目依赖
go get github.com/astaxie/beego
go get github.com/IoTServ/McuNode-server/mcunode/routers

# build
go build main.go
```
