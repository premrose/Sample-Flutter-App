import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class MainWidget extends  StatefulWidget {

  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {

  late Future<List<Model>> models;

  @override
  void initState() {
    super.initState();
    models = getModelsList();
  }

  Future<List<Model>> getModelsList() async {
    final response = await http.get(
        Uri.parse('https://firebasestorage.googleapis.com/v0/b/jill-soap-6a1ac.appspot.com/o/maps.json?alt=media&token=bfd28b0f-06d7-4d25-8d45-e218466c7449'));

    if (response.statusCode == 200) {
      final items = jsonDecode(response.body)['routes'][0]['legs'][0];
      return [Model.fromJson(items)];
    } else {
      throw Exception('Failed to load Data');
    }
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 3.2;
    final double itemWidth = size.width;

    return FutureBuilder<List<Model>>(
        future: models,
        builder: (BuildContext context, AsyncSnapshot<List<Model>> snapshot) {
          if(snapshot.hasData && snapshot.data!.isNotEmpty){
            return ListView.builder(
              scrollDirection : Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];

                return Column(
                  children: [
                    Container(
                      width: itemWidth,
                      height: itemHeight,
                      decoration: const BoxDecoration(
                        color : Color.fromRGBO(0, 56, 215, 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 20, bottom: 50),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("From",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(data.start_address,  textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Text("Total Km",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),),
                                            const SizedBox(height: 4),
                                            Text(data.distance,
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(
                                      color: Colors.white,
                                      thickness: 1.0,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                        mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("To",
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white,
                                                    fontSize: 15
                                                ),
                                              ),
                                              SizedBox(
                                                height: 40,
                                                child: Text(data.end_address,  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 4),
                                              const Text("Total Hrs",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),),
                                              const SizedBox( height: 4),
                                              SizedBox(
                                                width: 80,
                                                height: 40,
                                                child: Text(data.duration,  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ]
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      )
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Container(
                          height : itemHeight / 1.8,
                          width : itemWidth / 1.1,
                          padding: const EdgeInsets.only(top:5.0, bottom: 5.0, left: 15.0, right: 5.0, ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1.0,1.0), //Offset
                                  blurRadius: 1.0,
                                  spreadRadius: 0.2,
                                ),
                              ]
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data.roadTime.toUpperCase(),
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(data.roadPath,
                                                        style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                      const SizedBox(width:2.0),
                                                      Text(data.travelMode,
                                                        style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w800,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 5),
                                              child: Text(data.roadPath,
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.3,
                                        ),
                                        Text(data.htmlInstructions,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 12
                                          ),
                                        ),
                                      ],
                                    )
                                )

                              ]
                          ),
                        )
                    )
                  ]
                );

              }
            );
          }
          else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xffadadad),
                valueColor: AlwaysStoppedAnimation(Color(0xff000000)),
                semanticsLabel: 'wait a while',
              )
          );
        }
    );
  }
}

class ListHeading extends StatelessWidget {
  const ListHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 3;
    final double itemWidth = size.width;

    return Container(
      height : itemHeight / 4,
      width : itemWidth / 1.1,
      padding: const EdgeInsets.only(top:5.0, bottom: 5.0, left: 15.0, right: 5.0, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1.0,1.0), //Offset
            blurRadius: 1.0,
            spreadRadius: 0.2,
          ),
        ]
    ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("data.name".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: const [
                          Text('Rating',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width:2.0),
                          Text("data.location",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ],
            ),
            Row(
              children: const [
                Text("₹ +data.oldRate",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }
}
