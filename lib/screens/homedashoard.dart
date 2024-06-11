import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/global.dart';
import 'package:ecomoffice/screens/statscard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';
import '../dataase/dbfields.dart';

class Homedashboard extends StatefulWidget {
  TextEditingController tid_imput;
  String tid;
  bool norecord;
  bool checkstatus;
  final onNotification;
  Homedashboard({super.key,required this.tid,required this.norecord,required this.checkstatus,required this.tid_imput, required this.onNotification});

  @override
  State<Homedashboard> createState() => _HomedashboardState();
}

class _HomedashboardState extends State<Homedashboard> {
  bool optio=false;

  double alltotal=0;

//201712995764
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Global.bgs,
      body: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {
          String today="${value.year}-${value.currentMonth}-${value.dayNumberWithLeadingZero}";
          return NotificationListener<ScrollNotification>(
              onNotification: widget.onNotification,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Column(
                  children: [
                    FittedBox(
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            width:500,
                            decoration:  BoxDecoration(
                              color: Global.ksoft,
                              borderRadius: const BorderRadius.only(
                                  bottomRight:Radius.circular(60) ,
                                bottomLeft: Radius.circular(60)
                              ),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Sales:',
                                  style: TextStyle(fontSize: 24,color: Global.txtcolor),
                                ),
                                Text(
                                  '\$10,000',
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Global.txtcolor),
                                ),
                                SizedBox(height: 20),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("STAFF SALES SUMMARY FOR TODAY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                      ),
                    ),

                  ],
                ),
              )

          );
        },
      ),
    );
  }
}


