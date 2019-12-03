import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class DataAbout{
  String Label;
  String value;
}

class _AboutState extends State<About> {

  List<Map<String,String>> _listdataAbout = new List<Map<String,String> >();
  Map<String,String> _dataAbout  = new Map<String,String>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deviceInfo.androidInfo.then((val){
      setState(() {
        androidInfo = val;
        _dataAbout["OS"] = "DIPDroid";
        _dataAbout["Model"] = androidInfo.model;
        _dataAbout["ID"] = androidInfo.id;
        _dataAbout["Manufacture"] = androidInfo.manufacturer;
        _dataAbout["Kernel Version"] = androidInfo.version.incremental;
        _dataAbout["Board"] = androidInfo.board;
        _dataAbout["Brand"] = androidInfo.brand;
        _dataAbout["Host"] = androidInfo.host;
        _dataAbout["Android Version"] = androidInfo.version.release;
        _dataAbout["Version Code"] = androidInfo.version.codename;
        _listdataAbout.add(_dataAbout);
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close,color: Colors.white,),onPressed: ()=>Navigator.pop(context),),
        backgroundColor: Colors.black,
        title: Text("About Phone",style: TextStyle(color: Colors.white),),
      ),
      body: ListView.separated(
          padding: EdgeInsets.only(left: 15,right: 15),
          itemBuilder: (context,index){
            String key = _dataAbout.keys.elementAt(index);
            return Padding(
              padding: EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("${key}",),
                  Text("${_dataAbout[key]}",style: TextStyle(color: Colors.black38),softWrap: true,)
                ],
              ),
            );
          },
          separatorBuilder:  (context, index) => Divider(
            height: 1,
            thickness: 1,
            color: Colors.black26,
          ),
          itemCount: _dataAbout.length
      ),
    );
  }
}
