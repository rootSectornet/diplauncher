import 'dart:ui';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:launcher_assist/launcher_assist.dart';
import 'package:toast/toast.dart';

import 'about.dart';
import 'appspages.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}


class _HomescreenState extends State<Homescreen> {
  var numberOfInstalledApps;
  List<dynamic> installedApps;
  List<dynamic> appList;
  var wallpaper;
  String  formatDate(DateTime date) => new DateFormat("EEE, MMMM d").format(date);
   final String DIP_STORE_PACKAGE_NAME = "com.desktopip.dipappstore";
   final String TOOSTUDIO_PACKAGE_NAME = "com.desktopip.exploriztic.tootanium";
   final String ONLINE_STOREAGE_PACKAGE_NAME = "com.desktopip.exploriztic.tootanium";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Get all apps
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        installedApps = apps;
        appList = installedApps.where((val)=>val['package'] != "com.desktopip.diplauncher").toList();
        appList = appList.where((val)=>val['label'] != "Zim Launcher").toList();
//        installedApps.removeWhere((val){val["label"] == "diplauncher";});
        numberOfInstalledApps = apps.length;
      });
    });

    // Get wallpaper as binary data
    LauncherAssist.getWallpaper().then((imageData) {
      setState(() {
        wallpaper = imageData;
      });
    });
  }


  void ShowAppsheet(){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.black.withOpacity(0.5),
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 80,
                    child:  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.white,),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white,),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.white,),
                                  ),
                                  hintText: "Search..",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.filter_list,
                                    color: Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: appList.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (ctx,tc){

                        return InkWell(
                          onTap: ()=>LauncherAssist.launchApp(appList[tc]["package"]),
                          child:
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FilterImg(appList[tc]["label"]) == "0"
                                    ?
                                Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(appList[tc]["icon"])
                                        )
                                    ))
                                    : Image.asset(FilterImg(appList[tc]["label"]),height: 50,fit: BoxFit.cover,),
                                Center(
                                  child:
                                  Text("${appList[tc]["label"]}",softWrap: true,style: TextStyle(color: Colors.white,fontSize: 11),),
                                )
                              ],
                            ),
                          ),
                        );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(child: wallpaper != null
              ? new Image.memory(wallpaper, fit: BoxFit.scaleDown)
              : new Center()
          ),
          Positioned(
            bottom: 5,
            child: Container(
//              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10,right: 10),
              color: Colors.black.withOpacity(0.7),
              child: InkWell(
                onTap: ()=>ShowAppsheet(),
                child:  Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: Icon(Icons.keyboard_arrow_up,color: Colors.white,size: 20,),),
                    Center(child: Image.asset("assets/images/menu.png",height: 50,fit: BoxFit.cover,),),
                  ],
                ),
              )
            ),
          ),
          Positioned(
            top: 70,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(formatDate(new DateTime.now()),style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Positioned(
            top: 120,
            child: Container(
//              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width /1.1,
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset("assets/images/logo.png",height: 60,fit: BoxFit.cover,),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/dipstore.png",height: 50,fit: BoxFit.cover,),
                            Text("Dip App Store",softWrap: true,style: TextStyle(color: Colors.white,fontSize: 10),)
                          ],
                        ),
                        onTap: () async {
                          bool isInstalled = await DeviceApps.isAppInstalled(DIP_STORE_PACKAGE_NAME);
                          if(isInstalled){
                            DeviceApps.openApp(DIP_STORE_PACKAGE_NAME);
                          }else{
                            Toast.show("app not found", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }
                        },
                      ),
                      InkWell(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/too.png",height: 50,fit: BoxFit.cover,),
                            Text("tooTanium",softWrap: true,style: TextStyle(color: Colors.white,fontSize: 10),)
                          ],
                        ),
                        onTap: () async {
                          bool isInstalled = await DeviceApps.isAppInstalled(TOOSTUDIO_PACKAGE_NAME);
                          if(isInstalled){
                            DeviceApps.openApp(TOOSTUDIO_PACKAGE_NAME);
                          }else{
                            Toast.show("app not found", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }
                        },
                      ),
                      InkWell(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/online_storage.png",height: 50,fit: BoxFit.cover,),
                            Text("Online Storage",softWrap: true,style: TextStyle(color: Colors.white,fontSize: 10),)
                          ],
                        ),
                        onTap: () async {
                          bool isInstalled = await DeviceApps.isAppInstalled(TOOSTUDIO_PACKAGE_NAME);
                          if(isInstalled){
                            DeviceApps.openApp(TOOSTUDIO_PACKAGE_NAME);
                          }else{
                            Toast.show("app not found", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }
                        },
                      ),
                      InkWell(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/info.png",height: 50,fit: BoxFit.cover,),
                            Text("About Phone",softWrap: true,style: TextStyle(color: Colors.white,fontSize: 10),)
                          ],
                        ),
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => About())),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  String FilterImg(String label){
    switch (label) {
      case "Calendar":
        {
          return "assets/images/calender.png";
        }
        break;

      case "Settings":
        {
          return "assets/images/setting.png";
        }
        break;

      case "Gallery":
        {
          return "assets/images/image.png";
        }
        break;

      case "Clock":
        {
          return "assets/images/clock.png";
        }
        break;

      case "Files":
        {
          return "assets/images/file.png";
        }
        break;

      case "Browser":
        {
          return "assets/images/browser.png";
        }
        break;

      case "Calculator":
        {
          return "assets/images/calculator.png";
        }
        break;

      case "Camera":
        {
          return "assets/images/camera.png";
        }
        break;

      case "Contacts":
        {
          return "assets/images/contact.png";
        }
        break;

      case "Email":
        {
          return "assets/images/email.png";
        }
        break;

      case "FM Radio":
        {
          return "assets/images/radio.png";
        }
        break;
      case "Messaging":
        {
          return "assets/images/pesan.png";
        }
        break;
      case "Music":
        {
          return "assets/images/music.png";
        }
        break;
      case "Phone":
        {
          return "assets/images/phone.png";
        }
        break;

      case "dipappstore":
        {
          return "assets/images/dip_play_02.png";
        }
        break;

      default:
        {
          return "0";
        }
    }
  }

}
