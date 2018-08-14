# cordova-plugin-net-diagno

这是一个用于网络诊断的 cordova 插件. 利用ping和traceroute的原理, 
对指定域名（通常为后台API的提供域名）进行网络诊断, 并收集诊断日志. 
该插件集成了由网易提供的网络诊断开源代码, 
支持([IOS](https://github.com/Lede-Inc/LDNetDiagnoService_IOS) 
与 [android](https://github.com/Lede-Inc/LDNetDiagnoService_Android))

<<<<<<< HEAD

## Usage
=======
## Usage
>>>>>>> cf2cd933262c16184e42fcf36f8caa23fed21940

```js
window.netdiagno({ 
    // 指定的域名
    dormain: 'www.baidu.com', 
    // 开始
    onStart: () => {
        console.log('网络诊断开始......\n');
    },
    // 接收实时输出的日志数据
    onProgress: (output) => {
        console.log(output)
    },
    // 完成
    onFinished: (allOutput) => {
        console.log('网络诊断结束');
    },
    onError: (err) => {
        console('错误:' + err.toString());
    }
});
```
