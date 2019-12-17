import 'dart:async';

import 'package:launcher_assist/launcher_assist.dart';

class LBloc{
  StreamController _lBlocController;

  StreamSink<List<dynamic>> get streamsinklistapps => _lBlocController.sink;
  Stream<List<dynamic>> get streamlistapps => _lBlocController.stream;
  List<dynamic> AppList = List<dynamic>();
  List<dynamic> dummySearchList = List<dynamic>();
  List<dynamic> InstaledApps = List<dynamic>();
  LBloc(){

    _lBlocController = new StreamController<List<dynamic>>.broadcast();
    ambilData();
  }


  ambilData(){
    LauncherAssist.getAllApps().then((apps){
      print("then${apps}");
      streamsinklistapps.add(apps);
      InstaledApps = apps;
      AppList = apps;
    });
  }



  void filterSearchResults(String query) {
    dummySearchList.addAll(AppList);
    if(query.isNotEmpty) {
      List<dynamic> dummyListData = List<dynamic>();
      dummySearchList.forEach((item) {

        print(item['label'].contains(query));
        if(item['label'].contains(query)) {
          dummyListData.add(item);
        }
      });
      AppList.clear();
      AppList.addAll(dummyListData);
      return;
    } else {
//      setState(() {
      AppList.clear();
      AppList.addAll(InstaledApps);
//      });
    }

  }

  dispose(){
    _lBlocController?.close();
  }

}