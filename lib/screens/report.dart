import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/dataase/Dbfields.dart';
import 'package:ecomoffice/forms/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';

class Report extends StatelessWidget {
  TextEditingController tid_imput;
  String tid;
  bool norecord;
  bool checkstatus;
  bool optio=false;
  final onNotification;
  Report({super.key,required this.tid,required this.norecord,required this.checkstatus,required this.tid_imput, required this.onNotification});

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 900
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,50),
                child: NotificationListener<ScrollNotification>(
                    onNotification: onNotification,
                    child: Column(
                      children: [

                        Flexible(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: value.db.collection("items").where('companyemail', isEqualTo: 'info@kologsoft.com').snapshots(),
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
                                    final textedit=TextEditingController();
                                    textedit.text=snapshot.data!.docs[index][Dbfields.description];
                                    // String timestampString = value.ttime;
                                    // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString) * 1000);
                                    Icon respon=const Icon(Icons.camera_alt,color: Colors.green );
                                    // if(snapshot.data!.docs[index]['sync_status']==1)
                                    // {
                                    //   respon=Icon(Icons.done_all_outlined,color: Colors.blue );
                                    // }

                                    return  InkWell(
                                      onLongPress: ()async{
                                      //  print(value.tids[index]);
                                        //await value.confirmreceipt("supStaff", "supTime", value.keys[index],0);

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[50],
                                                border: Border.all(color: Colors.white),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(children: [

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      width: 100,
                                                      height: 100,
                                                      color:Colors.blueGrey[100],
                                                      child:CachedNetworkImage(imageUrl: snapshot.data!.docs[index][Dbfields.itemurl],fit:BoxFit.fill ,) , //ImageNetwork(image: snapshot.data!.docs[index][Dbfields.itemurl], height: 200, width: 200),
                                                    ),
                                                  )
                                                ],),
                                              SizedBox(width: 20,),
                                                Flexible(
                                                  child: Column(children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(snapshot.data!.docs[index][Dbfields.item],style: GoogleFonts.k2d(fontSize: 14,fontWeight: FontWeight.w900),),
                                                            Text("usd "+snapshot.data!.docs[index][Dbfields.sellingprice],style:GoogleFonts.k2d(fontSize: 14)),
                                                            const Divider(height: 10,color: Colors.black45,),
                                                            Text("Code: "+snapshot.data!.docs[index][Dbfields.code],style:GoogleFonts.k2d(fontSize: 14)),
                                                            Text("Category: "+snapshot.data!.docs[index][Dbfields.category],style:GoogleFonts.k2d(fontSize: 14)),
                                                            Divider(height: 10,color: Colors.black45,),
                                                            EditableText(
                                                              selectionColor: Colors.blue,
                                                                expands: true,
                                                                maxLines:null,
                                                                controller: textedit, focusNode: FocusNode(),
                                                                style: const TextStyle(fontSize: 14,color: Colors.black),
                                                                cursorColor:Colors.black ,
                                                                backgroundCursorColor: Colors.black),
                                                            Divider(height: 10,color: Colors.black45,),

                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: ElevatedButton(onPressed: ()async{
                                                                    final progress=ProgressHUD.of(context);
                                                                    progress!.show();
                                                                    await value.updatedes(textedit.text, snapshot.data!.docs[index].id);
                                                                    progress!.dismiss();
                                                                    SnackBar snackbar=const SnackBar(content: Text("Updated Successfully"),backgroundColor: Colors.green,);
                                                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);


                                                              },child: const Text("Update Description")),
                                                            ),
                                                          //  Text("Des: "+snapshot.data!.docs[index][Dbfields.description],style:GoogleFonts.k2d(fontSize: 14)),
                                                             Padding(
                                                               padding: const EdgeInsets.all(2.0),
                                                               child: Card(
                                                                 child: Container(
                                                                   child: Padding(
                                                                     padding: const EdgeInsets.all(4.0),
                                                                     child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        InkWell(child: Icon(Icons.qr_code,color: Colors.black54,),onTap: ()async{
                                                                          final login=await value.auth.signInWithEmailAndPassword(email: "info@kologsoft.com", password: "123456");

                                                                          print("$login");
                                                                        },),
                                                                        SizedBox(width: 20,),

                                                                        InkWell(child: Icon(Icons.delete,color: Colors.red,),onTap: (){

                                                                          print("Delte");
                                                                        },),
                                                                        SizedBox(width: 20,),

                                                                        InkWell(child: Icon(Icons.edit,color: Colors.amber,),onTap: (){
                                                                          String item=snapshot.data!.docs[index][Dbfields.item];
                                                                          String barcode=snapshot.data!.docs[index][Dbfields.code];
                                                                          String category=snapshot.data!.docs[index][Dbfields.category];
                                                                          String sellingprice=snapshot.data!.docs[index][Dbfields.sellingprice];
                                                                          String costprice=snapshot.data!.docs[index][Dbfields.costprice];
                                                                          String wholesaleprice=snapshot.data!.docs[index][Dbfields.wholesaleprice];
                                                                          String description=snapshot.data!.docs[index][Dbfields.description];
                                                                          String quantity=snapshot.data!.docs[index][Dbfields.quantity];
                                                                          String photo=snapshot.data!.docs[index][Dbfields.itemurl];
                                                                          String key=snapshot.data!.docs[index].id;
                                                                          Menus().editItems(context, item, barcode, sellingprice, costprice, wholesaleprice, description, category,quantity,photo,key);
                                                                          print("Edit");
                                                                        },),
                                                                        SizedBox(width: 20,),
                                                                        InkWell(child: Icon(Icons.camera_alt,color: Colors.teal,),onTap: ()async{
                                                                        ImageSource source=ImageSource.camera;
                                                                        await value.updateImage(source, snapshot.data!.docs[index].id);
                                                                        print(value.imageUrl);
                                                                      },),
                                                                      SizedBox(width: 20,),
                                                                      InkWell(child: Icon(Icons.image,color: Colors.blueGrey,),onTap: ()async{
                                                                        ImageSource source=ImageSource.gallery;
                                                                        await value.updateImage(source, snapshot.data!.docs[index].id);
                                                                        print(value.imageUrl);
                                                                      },)
                                                                                                                       ],),
                                                                   ),
                                                                 ),
                                                               ),
                                                             )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],),
                                                ),



                                              ],
                                            )),
                                      ),
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
            ),
          );
        },
      ),
    );
  }
}
