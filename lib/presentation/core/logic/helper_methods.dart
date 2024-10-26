import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
final navigatorKey = GlobalKey<NavigatorState>();
Future <dynamic> navigateTo(Widget page,{bool keepHistory=true,bool isReplacement = false}){
  if(isReplacement){
    return Navigator.pushReplacement(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => page),
    );
  }
  return Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => page,),
          (route) => keepHistory);
    // Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
    //   MaterialPageRoute(builder: (context) => page,),
    //       (route) => keepHistory);
}
enum MessageType{
  Success , warning ,erorr
}
 void showMessage (String msg,{MessageType messageType = MessageType.Success}){
   ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
       SnackBar(content: Text(msg),
    duration: Duration(seconds: 3),
         backgroundColor: messageType == MessageType.Success?Colors.green:messageType==MessageType.warning?Colors.orange:Colors.red,));

}
Future<void> openUrl(String url)async{
  await launchUrl(Uri.parse(url)).catchError((ex){
    showMessage("Can't Open The Url",messageType: MessageType.erorr);
    return false;
  });
}