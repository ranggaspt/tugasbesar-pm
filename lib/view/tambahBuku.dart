// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TambahBuku extends StatefulWidget {
  final VoidCallback reload;
  TambahBuku(this.reload);
  @override
  _TambahBukuState createState() => _TambahBukuState();
}

class _TambahBukuState extends State<TambahBuku> {
  String judulBuku, totalBuku, tahun, idUsers;
  final _key = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getString("id");
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    final response = await http.post(
        Uri.parse("http://192.168.43.171/tubes_mobile/api/addBuku.php"),
        body: {
          "judulBuku": judulBuku,
          "totalBuku": totalBuku,
          "tahun": tahun,
          "idUsers": idUsers
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
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
      appBar: AppBar(
        title: Text("Tambah Data Buku", style: TextStyle(fontSize: 18.0)),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              onSaved: (e) => judulBuku = e,
              decoration: InputDecoration(labelText: 'Judul Buku'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (e) => totalBuku = e,
              decoration: InputDecoration(labelText: 'Total Buku'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (e) => tahun = e,
              decoration: InputDecoration(labelText: 'Tahun Terbit'),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              height: 50,
              child: Text(
                "Simpan",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white),
              ),
              onPressed: () {
                check();
              },
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      ),
    );
  }
}
