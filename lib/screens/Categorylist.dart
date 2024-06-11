import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/dataase/Dbfields.dart';
import 'package:ecomoffice/forms/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';

class Categorylist extends StatelessWidget {
  bool norecord;
  bool checkstatus;
  bool optio=false;
  final onNotification;
  Categorylist({super.key,required this.norecord,required this.checkstatus, required this.onNotification});

  @override
  Widget build(BuildContext context) {
    return Consumer<FireData>(
      builder: (BuildContext context, FireData value, Widget? child) {

        return Scaffold(
          floatingActionButton: Container(margin:const EdgeInsets.fromLTRB(0, 0, 0, 100),child:TextButton.icon(onPressed: (){
            Menus().Addcategory(context);

          }, icon: const Icon(Icons.add), label: const Text("Add Category"))),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,50),
            child: NotificationListener<ScrollNotification>(
                onNotification: onNotification,
                child: Column(
                  children: [

                    Flexible(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: value.db.collection("category").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Center(child: Text("No Records yet",style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),));
                          }
                          if(snapshot.hasError)
                          {
                            return Center(child: Text("Error Loading Data",style: GoogleFonts.abel(textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),));

                          }
                          if(snapshot.connectionState==ConnectionState.waiting)
                          {
                            CircularProgressIndicator();
                          }
                          return Container(
                            decoration: const BoxDecoration(
                            ),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {

                                return  Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[50],
                                          border: Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              color:Colors.blueGrey[100],
                                              child:Icon(Icons.card_travel,size: 30,) , //ImageNetwork(image: snapshot.data!.docs[index][Dbfields.itemurl], height: 200, width: 200),
                                            )
                                          ],),
                                          const SizedBox(width: 20,),
                                          Column(children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(snapshot.data!.docs[index][Dbfields.name],style: GoogleFonts.k2d(fontSize: 14,fontWeight: FontWeight.w900),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            const SizedBox(width: 20,),
                                                            InkWell(child: const Icon(Icons.delete,color: Colors.red,),onTap: (){
                                                              value.deletecategory(snapshot.data!.docs[index].id);
                                                            },),
                                                            const SizedBox(width: 50,),
                                                            InkWell(child: const Icon(Icons.edit,color: Colors.amber,),onTap: (){
                                                              String name=snapshot.data!.docs[index][Dbfields.name];
                                                              String key=snapshot.data!.docs[index].id;
                                                             // Menus().editCategory(context, name, key);
                                                              print("Edit");
                                                            },),

                                                          ],),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],),



                                        ],
                                      )),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )

            ),
          ),
        );
      },
    );
  }
}
