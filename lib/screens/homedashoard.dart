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
    Size screen=MediaQuery.of(context).size;
    double width=screen.width;
    double height=screen.height;

    return Scaffold(
      backgroundColor: Global.bgs,
      body: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {
          String today="${value.year}-${value.currentMonth}-${value.dayNumberWithLeadingZero}";
          return NotificationListener<ScrollNotification>(
              onNotification: widget.onNotification,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:   BoxConstraints(
                    maxWidth:width ,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                
                      FittedBox(
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width:width,
                                decoration:  BoxDecoration(
                                  color: Global.ksoft,
                                  borderRadius: BorderRadius.circular(10)
                
                                ),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     Row(children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0,top: 15),
                                        child: Text(
                                          '${DateTime.timestamp()}',
                                          style: TextStyle(fontSize: 12,color: Global.txtcolor),
                                        ),
                                      ),
                                    ],),
                
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            child: const Row(
                                              children: [
                                                Icon(Icons.monetization_on,size: 70,color: Colors.green,),
                                                Text(
                                                  '10k',
                                                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,color: Global.txtcolor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                
                                        const Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text("Total Customers"),
                                                Text("50000"),
                                                Text("Weekly sales"),
                                                Text("GHC 10,200"),
                                              ],
                                            ),
                                          ),
                                        )
                                    ],),
                
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Mon',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Tue',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Wed',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Thur',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Fri:',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Sat:',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                                        Text(
                                          'Sun:',
                                          style: TextStyle(fontSize: 16,color: Global.txtcolor),
                                        ),
                
                                      ],),
                
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                                      Icon(Icons.arrow_downward,color: Colors.blueGrey,),
                
                                    ],),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                                        Text(
                                          '10,000',
                                          style: TextStyle(fontSize: 16,color: Global.gradient2),
                                        ),
                
                                      ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: width,
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
                ),
              )

          );
        },
      ),
    );
  }
}


