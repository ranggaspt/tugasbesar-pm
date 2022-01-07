import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tubes_mobile/bukuModel.dart';
import 'package:http/http.dart' as http;

class EditBuku extends StatefulWidget {
  final BukuModel model;
  final VoidCallback reload;
  EditBuku(this.model, this.reload);
  @override
  _EditBukuState createState() => _EditBukuState();
}

class _EditBukuState extends State<EditBuku> {
  final _key = new GlobalKey<FormState>();
  String judulBuku, totalBuku, tahun;

  TextEditingController txtNama, txtTotalBuku, txtTahun;

  setup() {
    txtNama = TextEditingController(text: widget.model.judulBuku);
    txtTotalBuku = TextEditingController(text: widget.model.totalBuku);
    txtTahun = TextEditingController(text: widget.model.tahun);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    final response = await http.post(
        Uri.parse("http://192.168.43.171/tubes_mobile/api/editBuku.php"),
        body: {
          "judulBuku": judulBuku,
          "totalBuku": totalBuku,
          "tahun": tahun,
          "idBuku": widget.model.id
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
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
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Buku", style: TextStyle(fontSize: 18.0)),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtNama,
              onSaved: (e) => judulBuku = e,
              decoration: InputDecoration(labelText: 'Nama Buku'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: txtTotalBuku,
              onSaved: (e) => totalBuku = e,
              decoration: InputDecoration(labelText: 'Total Buku'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: txtTahun,
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
