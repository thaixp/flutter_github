import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutter/common/funs.dart';
import 'package:myflutter/common/git_api.dart';
import 'package:myflutter/l10n/localization_intl.dart';
import 'package:myflutter/models/repo.dart';
import 'package:myflutter/models/user.dart';
import 'package:myflutter/states/profile_change_notifier.dart';
import 'package:myflutter/widgets/repo_item.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  final _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true; // 是否还有数据
  int page = 1; //当前请求的是第几页

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(), //构建主页面的显示内容
      drawer: const MyDrawer(), //抽屉
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      //用户未登录，显示登录按钮
      return Center(
        child: ElevatedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          //如果到了表尾
          if (_items[index].name == loadingTag) {
            //不足100条，继续获取数据
            if (hasMore) {
              //获取数据
              _retrieveData();
              //加载时显示loading
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              );
            } else {
              //已经加载了100条数据，不再获取数据。
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "没有更多了",
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
          }
          //显示单词列表项
          return RepoItem(_items[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: .0),
      );
    }
  }


  //请求数据
  void _retrieveData() async {
    var data = await Git(context).getRepos(
      queryParameters: {
        'page': page,
        'page_size': 20,
      },
    );
    //如果返回的数据小于指定的条数，则表示没有更多数据，反之则否
    hasMore = data.length > 0 && data.length % 20 == 0;
    //把请求到的新数据添加到items中
    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }

}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _builderHeader(), //抽屉头部
              Expanded(child: _builderMenus()) //功能菜单
            ],
          )),
    );
  }

  Widget _builderHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel value, Widget? child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  child: value.isLogin
                      ? gmAvatar(value.user!.avatarUrl!, width: 80)
                      : Image.asset(
                          "imgs/avatar-default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                value.isLogin
                    ? value.user!.login ?? ""
                    : GmLocalizations.of(context).login,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (!value.isLogin) Navigator.of(context).pushNamed("login");
        },
      );
    });
  }

  Widget _builderMenus() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget? child) {
      var gm = GmLocalizations.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text(gm.theme),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(gm.language),
            onTap: () => Navigator.pushNamed(context, "language"),
          ),
          if (userModel.isLogin) //登录了才显示注销
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.logout),
              onTap: () => {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text(gm.logoutTip),
                        actions: <Widget>[
                          TextButton(
                            child: Text(gm.cancel),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                              child: Text(gm.yes),
                              onPressed: () {
                                //该赋值语句会触发MaterialApp rebuild
                                userModel.user = null;
                                Navigator.pop(context);
                              })
                        ],
                      );
                    })
              },
            )
        ],
      );
    });
  }
}
