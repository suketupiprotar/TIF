import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tif/model/ModelData.dart';
import 'package:tif/model/all_event_model.dart';
import 'package:http/http.dart' as http;
import 'package:tif/screens/event_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List allEvents = [];

  Future<List> getEvents() async {
    final response = await http.get(
      Uri.parse(
          'https://sde-007.api.assignment.theinternetfolks.works/v1/event'),
    );

    var data = jsonDecode(response.body);
    // print(data['content']['data'][0]);
    List newlist = [];
    for (int i = 0; i < data['content']['meta']['total']; i++) {
      // print(i);
      newlist.add(data['content']['data'][i]);
    }
    allEvents = newlist;

    return allEvents;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getEvents();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        title: Text(
          'Events',
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Color(0xff120D26),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.search,
              color: Color(0xff120D26),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ImageIcon(
              AssetImage('images/menu.png'),
              size: 20,
              color: Color(0xff120D26),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getEvents(),
              builder: (context, snpashot) {
                if (!snpashot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // print("lenght");
                  // print(allEvents.length);
                  return ListView.builder(
                    itemCount: allEvents.length,
                    itemBuilder: (context, index) {
                      // Text(snpashot.data![index]['title'].toString())
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 4,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDatailsScreen(
                                    title: snpashot.data![index]['title'],
                                    description: snpashot.data![index]
                                        ['description'],
                                    banner_image: snpashot.data![index]
                                        ['banner_image'],
                                    date_time: snpashot.data![index]
                                        ['date_time'],
                                    organiserName: snpashot.data![index]
                                        ['organiser_name'],
                                    organiserIcon: snpashot.data![index]
                                        ['organiser_icon'],
                                    venueName: snpashot.data![index]
                                        ['venue_name'],
                                    venueCity: snpashot.data![index]
                                        ['venue_city'],
                                    venueCountry: snpashot.data![index]
                                        ['venue_country'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4,
                                          bottom: 4,
                                          left: 6,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            child: Image(
                                              height: 120,
                                              width: 107,
                                              image: NetworkImage(
                                                snpashot.data![index]
                                                        ['banner_image']
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat.MMMd().format(
                                                    DateTime.parse(
                                                      snpashot.data![index]
                                                          ['date_time'],
                                                    ),
                                                  ) +
                                                  " • " +
                                                  DateFormat.jm().format(
                                                    DateTime.parse(
                                                      snpashot.data![index]
                                                          ['date_time'],
                                                    ),
                                                  ),
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              snpashot.data![index]['title'],
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    color: Color(0xffB0B1BC),
                                                  ),
                                                  Text(
                                                    snpashot.data![index]
                                                        ['venue_country'],
                                                    style: GoogleFonts.inter(
                                                        color:
                                                            Color(0xff747688)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
