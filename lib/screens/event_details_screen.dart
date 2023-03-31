import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class EventDatailsScreen extends StatefulWidget {
  // const EventDatailsScreen({Key? key}) : super(key: key);
  String title;
  String description;
  String banner_image;
  String date_time;
  String organiserName;
  String organiserIcon;
  String venueName;
  String venueCity;
  String venueCountry;

  EventDatailsScreen({
    required this.title,
    required this.description,
    required this.banner_image,
    required this.date_time,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  @override
  State<EventDatailsScreen> createState() => _EventDatailsScreenState();
}

class _EventDatailsScreenState extends State<EventDatailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Event Details',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 10,
                width: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Color.fromARGB(76, 255, 255, 255),
                    shape: BoxShape.rectangle),
                child: Container(
                  height: 0.4,
                  width: 0.4,
                  child: Image.asset(
                    'images/bookmark.png',
                    width: 0.5,
                    height: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.banner_image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 21, right: 38, left: 24),
                child: Container(
                  width: 313,
                  height: 40,
                  child: Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 51,
                      width: 54,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(120, 239, 239, 240),
                          borderRadius: BorderRadius.circular(15)
                          // color: Colors.white
                          ),
                      child: widget.organiserIcon.contains('.svg')
                          ? SvgPicture.network(
                              widget.organiserIcon,
                              semanticsLabel: 'Organiser Icon',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child:
                                          const CircularProgressIndicator()), //placeholder while downloading file.
                            )
                          : Image(
                              image: NetworkImage(widget.organiserIcon),
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.organiserName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Organizer',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(76, 86, 105, 255),
                            borderRadius: BorderRadius.circular(15)
                            // color: Colors.white
                            ),
                        child: Icon(
                          Icons.calendar_month,
                          color: Color(0xffff5669ff),
                          size: 35,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.organiserName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat.EEEE().format(
                                DateTime.parse(
                                  widget.date_time,
                                ),
                              ) +
                              "," +
                              " " +
                              DateFormat.jm().format(
                                DateTime.parse(
                                  widget.date_time,
                                ),
                              ),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(76, 86, 105, 255),
                            borderRadius: BorderRadius.circular(15)
                            // color: Colors.white
                            ),
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xffff5669ff),
                          size: 35,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.venueName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xff0D0C26),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.venueCity + "," + " " + widget.venueCountry,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706E8F),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  'About Event',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff120D26),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Container(
                  height: 112,
                  width: 335,
                  child: SingleChildScrollView(
                    child: ReadMoreText(
                      widget.description,
                      trimLines: 4,
                      colorClickableText: Color(0xff5669FF),
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffff5669ff),
                      ),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: (){
                    print('Pressed');
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xff5669FF),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff3D56F0),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Book Now',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff3D56F0),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
