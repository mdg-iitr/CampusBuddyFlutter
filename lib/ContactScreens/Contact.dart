import 'package:campusbuddy/ContactScreens/ContactList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Contact extends StatelessWidget {
  PassToContact passToContact;
  static const routeName='/contact';
  static const Color color = const Color(0xff303e84);
  Future<void> _launched;
  static const String assetName = 'assets/contactPerson.svg';
  static const String assetNameAdd = 'assets/addContact.svg';
  List<String> emailAndPhoneNo = [];
  List<String> subHeadings = [];
  final Widget svgIcon = SvgPicture.asset(
    assetName,
    color: Colors.white,
    width: 42.w,
    height: 42.h,
  );
  final Widget svgIconAdd = SvgPicture.asset(
    assetNameAdd,
    color: Colors.white,
    width: 42.w,
    height: 42.h,
  );
  @override
  Widget build(BuildContext context) {
    if (passToContact.office != "") {
      emailAndPhoneNo.add(passToContact.office);
      subHeadings.add("Office | Main");
    }
    if (passToContact.residence != "") {
      emailAndPhoneNo.add(passToContact.residence);
      subHeadings.add("Residence | Main");
    }
    if (passToContact.email != "") {
      emailAndPhoneNo.add(passToContact.email + "@iitr.ac.in");
      subHeadings.add("IITR Email");
    }
    return ScreenUtilInit(
      designSize: Size(410,703),
      allowFontScaling: true,
      builder: ()=>Scaffold(
          appBar: AppBar(
            backgroundColor: color,
            elevation: 0,
            actions: [
              /*IconButton(
                icon: svgIconAdd,
                onPressed: () {},
              )*/
            ],
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: color,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: svgIcon,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 4.w, color: Colors.white),
                        color: color,
                      ),
                    ),
                    SizedBox(
                      height: 9.2.h,
                    ),
                    Text(
                      passToContact.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      passToContact.department,
                      style: TextStyle(
                          color: Colors.white, fontSize: ScreenUtil().setSp(17)),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      passToContact.sub,
                      style: TextStyle(
                          color: Colors.white, fontSize: ScreenUtil().setSp(17)),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.fromLTRB(13.5, 8.5, 13.5, 0),
                child: new ListView.builder(
                    itemCount: emailAndPhoneNo.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (subHeadings[index] == "IITR Email") {
                            _makeEmail(emailAndPhoneNo[index]);
                          } else {
                            String tell = emailAndPhoneNo[index];
                            _launched = _makePhoneCall('tel:$tell');
                          }
                        },
                        child: new Card(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emailAndPhoneNo[index],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: ScreenUtil().setSp(20)),
                                ),
                                SizedBox(
                                  height: 5.25.h,
                                ),
                                Text(
                                  subHeadings[index],
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: ScreenUtil().setSp(17.52)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ])),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makeEmail(String url) async {
    final Email email = Email(
      recipients: ['$url'],
      isHTML: false,
    );
    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
  }

  Contact(this.passToContact);
}
