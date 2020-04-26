import 'package:campusbuddy/ContactScreens/ContactList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Contact extends StatefulWidget {
  static Color color= const Color(0xff303e84);
  static String assetName = 'assets/contactPerson.svg';
  static String assetNameAdd = 'assets/addContact.svg';
  @override
  _ContactState createState() => _ContactState();
}
class _ContactState extends State<Contact> {

  List<String> emailAndPhoneNo=[];
  List<String> subHeadings=[];
  final Widget svgIcon = SvgPicture.asset(
      Contact.assetName,
      color: Colors.white,
      width: 42.w,
      height: 42.h,
  );
  final Widget svgIconAdd = SvgPicture.asset(
      Contact.assetNameAdd,
      color: Colors.white,
      width: 42.w,
      height: 42.h,
  );
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true, width: 410, height: 703);
    final PassToContact pass = ModalRoute.of(context).settings.arguments;
   if(pass.office!="") {emailAndPhoneNo.add(pass.office);
    subHeadings.add("Office | Main");}
   if(pass.residence!=""){ emailAndPhoneNo.add(pass.residence);
    subHeadings.add("Residence | Main");}
    if(pass.email!=""){emailAndPhoneNo.add(pass.email);
    subHeadings.add("IITR Email");}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Contact.color,
        elevation: 0,
        actions: [
          IconButton(
            icon: svgIconAdd,
            onPressed: (){
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
      children: [Container(
        color: Contact.color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child:
                Padding(
                    padding: EdgeInsets.all(10),
                    child: svgIcon),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 4.w, color: Colors.white),
                  color: Contact.color,
                ),
              ),
            SizedBox(
              height: 9.2.h,
            ),
              Text(pass.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(20),
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                height: 20.h,
              ),
              Text(pass.department,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(17)
                ),),
              SizedBox(
                height: 22.h,
              ),
              Text(pass.sub,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(17)
                ),)
             , SizedBox(
                height: 9.h,
              ),
            ],
          ),
        ),
      ),
       Flexible(
         child: Padding(
          padding: EdgeInsets.fromLTRB(13.5, 8.5, 13.5, 0),
          child:  new ListView.builder
            (
              itemCount: emailAndPhoneNo.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child:Padding(
                    padding: EdgeInsets.fromLTRB(12, 16, 0, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(emailAndPhoneNo[index]
                        ,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(20)
                        ),),
                        SizedBox(
                          height: 5.25.h,
                        ),
                        Text(subHeadings[index], style: TextStyle(
                          color: Colors.black38,
                          fontSize: ScreenUtil().setSp(17.52)
                        ),),
                      ],
                    ),
                  ),
                );
              }
          ),
      ),
       ),]
    )
    );
  }
}