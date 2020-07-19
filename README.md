# JudyFlutter

该项目利用了三周的业余时间是使用纯 Flutter 仿开眼 app 的一个练手项目，也是第一次使用 Flutter 开发项目。在此之前学习 Kotlin 时也仿过一次，这次是基于 [Kotlin 版本](https://github.com/Walkud/JudyKotlinMvp) 开发。

## 效果图

#### Flutter Android 

<img src="./gif/android_home_page.gif" width="20%">

<!--#### Flutter Android 

首页|发现|热门|我的
----|----|---|---
<img src="./gif/android_home_page.gif" width="100%">|<img src="./gif/android_discovery_page.gif" width="100%">|<img src="./gif/android_hot_page.gif" width="100%">|<img src="./gif/android_mine_page.gif" width="100%">-->

<!--#### Flutter iOS

首页|发现|热门|我的
----|----|---|---
<img src="./gif/ios_home_page.gif" width="100%">|<img src="./gif/ios_discovery_page.gif" width="100%">|<img src="./gif/ios_hot_page.gif" width="100%">|<img src="./gif/ios_mine_page.gif" width="100%">-->

#### Kotlin 版本

<img src="./gif/JudyKotlinMvpGif.gif" width="20%">

## 下载安装

#### Android

![Android 二维码](https://www.pgyer.com/app/qrcode/nhuz)

#### iOS 

请自行 clone 项目编译运行。

## 项目结构

```
./judyty
├── README.md			//项目说明文档
├── android				//Android 原生目录
├── build				//构建输出
├── fonts				//字体资源
├── images				//图片资源
├── ios					//iOS 原生目录
├── lib					//Flutter 源代码目录
│   ├── api					//后端 Api 接口模块
│   ├── db					//数据库模块
│   ├── main.dart			//主文件(入口)
│   ├── model				//业务模型(实体)
│   ├── pages				//页面模块
│   ├── utils				//工具类模块
│   └── widget			//自定义组件模块
├── local.properties	//本地属性文件
├── pubspec.lock		//Flutter 包依赖标识信息
├── pubspec.yaml		//Flutter 配置文件
├── test				//Flutter 测试目录
└── ty.iml				//Flutter 项目目录描述文件

```

## 应用功能

* 启动页
	* 获取应用版本号
	* 申请应用权限
* 主页底部 BottomNavigationBar 高斯模糊
* 每日精选
	* ToolBar（根据滑动显示当前视频的日期）
	* Banner 
* 发现
	*  关注页（竖向 ListView 嵌套 横向 ListView）
	*  分类页
* 热门
	* 周排行页
	* 月排行页
	* 总排行页
* 我的
	* 关于
	* 观看记录列表
* 搜索页
* 分类详情列表页
	* FloatingActionButton 滚动与缩放效果与 ListView 联动
	* AppBar 字体与返回图标根据滑动距离计算颜色渐变效果 
* 视频播放详情页
* 其它功能	
	* 改变状态栏颜色
	* 跳转外部游览器
	* 锁定设备方向
	* sqlite 使用
	* 当前网络状态监测

> Flutter 版本与 Kotlin 版本差异很小，主要是界面切换动画未做，搜索页面的关键词布局存在差异。

## 心得

* Flutter 上手比 RN 要容易
	* 从搭建环境到让项目 run 起来，再到排查问题，Flutter 提示相对更友好。
* Flutter 应用接近原生性能
	* 通过 release 模式运行，用肉眼感觉不出是 Flutter 开发。
* Flutter 套娃式布局需要慢慢习惯
    * 最开始上手时，套娃式布局真心不习惯，开发效率很低，到后来对组件熟悉度的提高，开发效率还是很不错。
* Flutter 一切皆组件
    * 如果有原生开发经验，开发上手时会遇到设置间距的困扰，例如绝大多绪组件没有 padding 的属性，其实设置间距也需要一层Padding组件，带有属性的组件内部也是套了一层Padding组件；还有动画、点击事件、手势等都是组件。
* 使用 setState() 遵循最小化原则
    * 开发项目首页时，滑动出现卡顿不流畅现象，最终原因就是因为对 StatefulWidget 使用没掌握引起，只在已改变状态的组件中调用该方法(不要在最外层组件调用)，建议看一下[咸鱼性能分析文章](https://www.jianshu.com/p/00448159dd78)。
* Flutter 开发还是得会原生
	* 虽然 Flutter 生态越来越完善,但系统差异、依赖方式、打包方式的不同，一旦涉及复制场景还是得需要原生支持，至少得会一些原生基础，会增加一些学习成本。
* Flutter 的相关文章还是比较缺乏，很多都是相互抄，不过基础性问题还是能查到。


## 第三方依赖

#### dependencies

名称|说明
----|----
[package_info](https://pub.dev/packages/package_info)| 包信息组件
[retrofit](https://pub.dev/packages/retrofit)|网络请求组件
[dio](https://pub.dev/packages/dio)|网络请求组件
[json_annotation](https://pub.dev/packages/json_annotation)| Json组件相关，与实体互转注解组件
[flutter_swiper](https://pub.dev/packages/flutter_swiper)|轮播组件
[fluttertoast](https://pub.dev/packages/fluttertoast)| Toast 组件
[permission_handler](https://pub.dev/packages/permission_handler)|权限组件
[awsome\_video\_player](https://pub.dev/packages/awsome_video_player)|视频播放组件
[video_player](https://pub.dev/packages/video_player)|视频播放组件
[connectivity](https://pub.dev/packages/connectivity)|当前网络类型检测组件
[url_launcher](https://pub.dev/packages/url_launcher)|原生 Schema 跳转组件
[sqflite](https://pub.dev/packages/sqflite)| Sqlite 组件
[auto_orientation](https://pub.dev/packages/auto_orientation)|屏幕方向组件


#### dev_dependencies

名称|说明
----|----
[retrofit_generator](https://pub.dev/packages/retrofit_generator)|网络请求组件，retrofit生成器
[json_serializable](https://pub.dev/packages/json_serializable)| Json组件相关，序列化
[build_runner](https://pub.dev/packages/build_runner)| Json组件相关 生成代码组件，执行命令：flutter packages pub run build_runner build

## 注意事项

#### retrofit 使用注意几点：

* 定义抽象类，并在类上加注解。

```
@RestApi(baseUrl: 'http://xxx.xxx.xxx/xxx/')
```

* 在类上添加 part 'xxx.g.dart'; 声明，xxx是文件名。

* 在类上添加如下代码，然后执行 build 代码生成命令。

```
factory 类名(Dio dio, {String baseUrl}) = _类名;
```

#### retrofit 使用 build 代码生成命令行。

```
# flutter
flutter pub run build_runner build

```

## 问题记录

* 播放组件在 iOS 平台上存在 Bug，一直 Loadding，加载不出视频，组件本身Bug，待组件更新或者也可以用别的组件替代。

## 总结

2019年定的目标终于被实现，在项目中最大的收获就是每天坚持前进一点点，把最开始觉得很难完成的任务一点一点的啃完，后续还有很多东西需要去学习，这个项目只是简单的用 Flutter 完成开发，实际项目开发中的很多问题其实并没有遇到，比如原生 Flutter 间路由和集成等问题，加油吧！

## 插曲

在发现 iOS 应用图标不对时，开始就拿 Android 的图标代替，发现图标放在 iOS 上存在黑色背景(-_-)，在完美主义的迫使下，在网上搜索开眼的iOS对应的图标，不搜不知道，一搜网上用 Flutter 仿开眼的开源项目一大堆，两年前就有了，赶紧围观各位大佬的杰作,对比了一圈后发现仿的版本大都不太一样，虽然自己的项目还很多不足，但已经挺满意了，最后还是没有找到当前版本对应的图标，看着不爽就忍忍吧，完美主义病得治。


## 声明

**项目中的 API 均来自开眼视频，纯属学习交流使用，不得用于商业用途！**

## License

Copyright [2020] [Walkud]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


