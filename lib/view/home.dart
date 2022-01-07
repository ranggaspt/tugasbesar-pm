import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nama = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("nama");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Text("Selamat Datang",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Text("$nama",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 3,
            ),
            Text("Ayo mulai kelola data buku perpustakaan!",
                style: TextStyle(fontSize: 15.0)),
          ],
        ),
      ),
    );
  }
}
