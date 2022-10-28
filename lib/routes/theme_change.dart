import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutter/common/Global.dart';
import 'package:myflutter/l10n/localization_intl.dart';
import 'package:myflutter/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget{
  const ThemeChangeRoute({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).theme),
      ),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: (){
              Fluttertoast.showToast(msg: e.toString());
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context,listen: false).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }

}