import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tubes_mobile/bukuModel.dart';
import 'package:tubes_mobile/view/editBuku.dart';
import 'package:tubes_mobile/view/tambahBuku.dart';

class Buku extends StatefulWidget {
  @override
  _BukuState createState() => _BukuState();
}

class _BukuState extends State<Buku> {
  var loading = false;
  final list = new List<BukuModel>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(
      Uri.parse("http://192.168.43.171/tubes_mobile/api/lihatBuku.php"),
    );
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new BukuModel(api['id'], api['judulBuku'], api['totalBuku'],
            api['tahun'], api['createDate'], api['idUsers'], api['nama']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _delete(String id) async {
    final response = await http.post(
        Uri.parse("http://192.168.43.171/tubes_mobile/api/deleteBuku.php"),
        body: {"idBuku": id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TambahBuku(_lihatData)));
          },
        ),
        body: RefreshIndicator(
          onRefresh: _lihatData,
          key: _refresh,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(x.judulBuku,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                Text(x.totalBuku),
                                Text(x.tahun),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Admin:", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(x.nama),
                                Text(x.createDate),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditBuku(x, _lihatData)));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _delete(x.id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ));
  }
}
