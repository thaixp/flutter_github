import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myflutter/l10n/localization_intl.dart';
import 'package:myflutter/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget{
  const LanguageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);

    Widget _buildLanguageItem(String lan,dynamic value){
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing: localeModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: (){
          // 此行代码会通知MaterialApp重新build
          localeModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null)
        ],
      ),
    );
  }

}