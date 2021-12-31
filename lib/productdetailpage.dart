import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'room.dart';

class DetailPage extends StatefulWidget {
  final Rooms room;
  const DetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late double screenHeight, screenWidth, resWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
      ),
      body: Column(children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: screenHeight / 2.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: CachedNetworkImage(
                    width: screenWidth * 0.9,
                    fit: BoxFit.cover,
                    imageUrl: "https://slumberjer.com/rentaroom/images/" +
                        widget.room.roomid.toString() +
                        "_1.jpg",
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight / 2.5,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: CachedNetworkImage(
                        width: screenWidth,
                        fit: BoxFit.cover,
                        imageUrl: "https://slumberjer.com/rentaroom/images/" +
                            widget.room.roomid.toString() +
                            "_2.jpg",
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))),
              SizedBox(
                  height: screenHeight / 2.5,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: CachedNetworkImage(
                        width: screenWidth,
                        fit: BoxFit.cover,
                        imageUrl: "https://slumberjer.com/rentaroom/images/" +
                            widget.room.roomid.toString() +
                            "_3.jpg",
                        placeholder: (context, url) =>
                            const LinearProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (Card(
              elevation: 10,
              child: (Container(
                padding: const EdgeInsets.all(20),
                child: (Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.3),
                    1: FractionColumnWidth(0.05),
                    2: FractionColumnWidth(0.65)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: [
                    TableRow(children: [
                      Text('Room Title',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(widget.room.title.toString(),
                          style: TextStyle(
                              fontSize: resWidth * 0.035,
                              fontWeight: FontWeight.bold))
                    ]),
                    TableRow(children: [
                      Text('Description',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(widget.room.description.toString(),
                          style: TextStyle(fontSize: resWidth * 0.035))
                    ]),
                    TableRow(children: [
                      Text('Price per month',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "RM " +
                              double.parse(widget.room.price.toString())
                                  .toStringAsFixed(2),
                          style: TextStyle(fontSize: resWidth * 0.035))
                    ]),
                    TableRow(children: [
                      Text('Deposit',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "RM " +
                              double.parse(widget.room.deposit.toString())
                                  .toStringAsFixed(2),
                          style: TextStyle(fontSize: resWidth * 0.035))
                    ]),
                    TableRow(children: [
                      Text('State',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(widget.room.state.toString(),
                          style: TextStyle(fontSize: resWidth * 0.035))
                    ]),
                    TableRow(children: [
                      Text('Area',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(widget.room.area.toString(),
                          style: TextStyle(fontSize: resWidth * 0.035))
                    ]),
                    TableRow(children: [
                      Text('Contact Number',
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(":",
                          style: TextStyle(
                              fontSize: resWidth * 0.03,
                              fontWeight: FontWeight.bold)),
                      Text(widget.room.contact.toString(),
                          style: TextStyle(
                              fontSize: resWidth * 0.035,
                              fontWeight: FontWeight.bold)),
                    ]),
                  ],
                )),
              )))),
        ),
      ]),
    );
  }
}
