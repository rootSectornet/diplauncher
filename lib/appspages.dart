import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsPages extends StatefulWidget {
  @override
  _AppsPagesState createState() => _AppsPagesState();
}

class _AppsPagesState extends State<AppsPages> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true, includeSystemApps: false, onlyAppsWithLaunchIntent: true),
      builder: (context,data){
        if(data.data == null){
          return Center(child: CircularProgressIndicator());
        }else{
          List<Application> apps = data.data;

          return Container(
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                ),
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: apps.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder: (ctx,tc){
                    Application app = apps[tc];
                    return InkWell(
                      child:
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${app.appName}",softWrap: true,)
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }


  void filterIcon(String packageName){

  }


}
