### 工具

- [ESPlorer IDE](https://esp8266.ru/esplorer/)
- [CP210x 驱动](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers)
- [构建固件](https://nodemcu-build.com/)
- [刷机工具-nodemcu-flasher](https://github.com/nodemcu/nodemcu-flasher)
- [刷机工具-nodemcu-pyflasher](https://github.com/marcelstoer/nodemcu-pyflasher)

### 准备工作
1. 根据nodemcu板子来安装驱动,有ch340g/cp210x之分,注意看一下自己的板子
2. 构建固件.你可以在网站上选择自己需要的模块,然后进行构建.几分钟,就会发到你的邮箱里.
3. 刷固件,有两个工具.flasher已经很久没有更新了.就想着用pyflasher,但是在我的PC上出现了 Hard Resting... 然后卡死了. flasher反而能成功刷入.
4. 成功刷好后,打开ESPlorer.选择对应的端口,点击open.然后！！！**记得按一下板子上的复位键**,这样就链接成功了.ESPlorer有一些snippets,你可以通过点击  ‘chip Info’ 等看看是否能正常返回

#### 点亮板子上的LED
```lua
function gpio_low(pin)
    gpio.mode(pin,gpio.OUTPUT)  
    gpio.write(pin, gpio.LOW)
end

gpio_low(0);
gpio_low(4);
```


### 其它
- [NodeMCU-HTTP-Server](https://github.com/wangzexi/NodeMCU-HTTP-Server)

### 参考资料
- [lua教程](http://www.runoob.com/lua/lua-tutorial.html)
- [nodemcu文档](https://nodemcu.readthedocs.io/en/master/)


```
uart.setup( 0, 9600, 8, 0, 1, 0 )
uart.on("data", 0, 
function(data)
    --print("len:"..#data);
    --util.gpio_low(LED0)
    --util.gpio_high(LED0)
    print(string.len(data));
    print(string.byte(data,1)==0x42)
    if((string.len(data)==32) and (string.byte(data,1)==0x42) and (string.byte(data,2)==0x4d))  then
        --util.gpio_low(LED1)
        ----------------------------------------------------------
        pm25 = (string.byte(data,13)*256+string.byte(data,14)) 
        print("pm25 = "..pm25)
        ----------------------------------------------------------
        -- uploaddata
    end
end, 0)
```