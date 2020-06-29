# ty

JudyTyFlutter

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

> 另一个原生仿开眼app地址：http://www.imooc.com/article/301354


retrofit 使用注意几点：

* 定义抽象类，并在类上加注解。

```
@RestApi(baseUrl: 'http://xxx.xxx.xxx/xxx/')
```

* 在类上添加 part 'xxx.g.dart'; 声明，xxx是文件名。

* 在类上添加如下代码，然后执行 build 代码生成命令。

```
factory 类名(Dio dio, {String baseUrl}) = _类名;
```

retrofit 使用 build 代码生成命令行。

```

# dart
pub run build_runner build

# flutter
flutter pub run build_runner build

```

# TODO List
* 播放记录页面 (完成)
* 分类页面 (完成)
* 搜索页面 (完成)
* 首页列表 Title 联动功能 (完成)
* 状态栏背景色与字体颜色优化 (完成)
* 卡顿优化(Debug模式很卡，Release模式很流畅)，完成首页优化，数据更新时调用setState时，尽量使用最小化更新原则
* 修改观看记录列表背景颜色及滑动Bug(完成)
* 修复视频详细界面切换视频功能Bug(完成)
* 修改搜索页面第一张图片不能平铺显示Bug(完成)
* 添加设备方向锁定(完成)
* git 初始化
* 写README
* 打包测试
