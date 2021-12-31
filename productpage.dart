import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'productdetailpage.dart';
import 'room.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late double screenHeight, screenWidth, resWidth;
  List roomList = [];
  int totalRoom = 0, scrollcount = 10, rowcount = 2;
  String titleCenter = "Loading...";
  late ScrollController scrollControl;

  @override
  void initState() {
    super.initState();
    scrollControl = ScrollController();
    scrollControl.addListener(_scrollListener);
    _loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('RentaRoom Products'),
        ),
        body: roomList.isEmpty
            ? Center(
                child: Column(children: [
                const CircularProgressIndicator(),
                Text(titleCenter,
                    style: TextStyle(
                        fontSize: resWidth * 0.05, fontWeight: FontWeight.bold))
              ]))
            : Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(totalRoom, (int i) {
                        return Card(
                          child: SizedBox(
                            width: resWidth * 0.5,
                            height: screenHeight * 0.2,
                            child: CachedNetworkImage(
                              width: screenWidth,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://slumberjer.com/rentaroom/images/" +
                                      (1 + i).toString() +
                                      "_1.jpg",
                              placeholder: (context, url) =>
                                  const LinearProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Text("Rooms Available",
                      style: TextStyle(
                          fontSize: resWidth * 0.04,
                          fontWeight: FontWeight.bold)),
                  Text(totalRoom.toString() + " Rooms are Available",
                      style: TextStyle(fontSize: resWidth * 0.03)),
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: rowcount,
                        controller: scrollControl,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        children: List.generate(scrollcount, (index) {
                          return Card(
                            color: Colors.blue[50],
                            child: InkWell(
                              onTap: () => {_loadDetails(index)},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                        _shortTitle(roomList[index]['title']
                                            .toString()),
                                        style: TextStyle(
                                            fontSize: resWidth * 0.04,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: screenHeight * 0.015),
                                    Text(
                                        "Price: RM " +
                                            double.parse(
                                                    roomList[index]['price'])
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: resWidth * 0.035)),
                                    Text(" per month",
                                        style: TextStyle(
                                            fontSize: resWidth * 0.035)),
                                    SizedBox(height: screenHeight * 0.015),
                                    Text(
                                        "Deposit: RM " +
                                            double.parse(
                                                    roomList[index]['deposit'])
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: resWidth * 0.035)),
                                    SizedBox(height: screenHeight * 0.015),
                                    Text("Area: " + roomList[index]['area'],
                                        style: TextStyle(
                                            fontSize: resWidth * 0.035)),
                                    SizedBox(height: screenHeight * 0.015),
                                    Text("Click to view more",
                                        style: TextStyle(
                                            fontSize: resWidth * 0.04,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ],
              ));
  }

  void _loadRooms() {
    http.post(Uri.parse('https://slumberjer.com/rentaroom/php/load_rooms.php'),
        body: {}).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        var getdata = data['data'];
        setState(() {
          roomList = getdata['rooms'];
          totalRoom = roomList.length;
          if (scrollcount >= roomList.length) {
            scrollcount = roomList.length;
          }
        });
      } else {
        setState(() {
          titleCenter = "No Rooms";
        });
      }
    });
  }

  void _scrollListener() {
    if (scrollControl.offset >= scrollControl.position.maxScrollExtent &&
        !scrollControl.position.outOfRange) {
      setState(() {
        if (roomList.length > scrollcount) {
          scrollcount += 10;
          if (scrollcount >= roomList.length) {
            scrollcount = roomList.length;
          }
        }
      });
    }
  }

  _loadDetails(int index) {
    Rooms room = Rooms(
        roomid: roomList[index]['roomid'],
        contact: roomList[index]['contact'],
        title: roomList[index]['title'],
        description: roomList[index]['description'],
        price: roomList[index]['price'],
        deposit: roomList[index]['deposit'],
        state: roomList[index]['state'],
        area: roomList[index]['area'],
        dateCreated: roomList[index]['dateCreated'],
        latitude: roomList[index]['latitude'],
        longitude: roomList[index]['longitude']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailPage(room: room)));
  }

  String _shortTitle(String string) {
    if (string.length > 15) {
      string = string.substring(0, 15);
      return string + "...";
    } else {
      return string;
    }
  }
}
