import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tif/screens/event_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xffF5F5F5),
        iconTheme: IconThemeData(
          color: Color(0xff120D26),
        ),
        title: Text(
          'Search',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Color(0xff120D26),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 31,
          left: 27,
          right: 27,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: Color(0xff5669FF),
                  size: 28,
                ),
                // Divider(color: Colors.black,height: 26,),
                VerticalDivider(
                    color: Color(
                      0xff5669ff,
                    ),
                    width: 26,
                    thickness: 2),
                Container(
                  height: 32,
                  width: 277,
                  // color: Colors.black26,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Event Name',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: FutureBuilder(
                future: getEvents(),
                builder: (context, snpashot) {
                  if (!snpashot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: allEvents.length,
                      itemBuilder: (context, index) {
                        String name = snpashot.data![index]['title'];
                        if (searchController.text.isEmpty) {
                          return InkWell(
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
                                            AutoSizeText(
                                              snpashot.data![index]['title'],
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,

                                              ),maxLines: 2,
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
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
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
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
