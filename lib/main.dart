import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker/pages/home_page.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:tracker/helpers/notification_helper.dart' as NotificationHelper;

void backgroundFetchHeadlessTask(String taskId) async {
    NotificationHelper.showNotification(title:null);
    BackgroundFetch.finish(taskId);
  }
void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(35, 47, 62, 1),
  ));
  runApp(MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tracker',
        home: HomePage());
  }
}
