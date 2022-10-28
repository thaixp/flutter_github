
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutter/models/cacheConfig.dart';
import 'package:myflutter/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'git_api.dart';
import 'net_cache.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

/// 全局的配置信息类 全局变量跟全局共享状态
class Global{
  static late SharedPreferences _prefs;
  static Profile profile = Profile();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，异步操作
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }else{
      // 默认主题索引为0，代表蓝色
      profile= Profile()..theme=0;
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    //初始化网络请求相关配置
    Git.init();
  }


  static saveProfile() => //更新数据
    _prefs.setString("profile", jsonEncode(profile.toJson()));

}