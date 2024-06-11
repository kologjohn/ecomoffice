import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecomoffice/forms/inputfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';
import '../global.dart';

class Home extends StatelessWidget {
  TextEditingController tid_imput;
  String tid;
  bool norecord;
  bool checkstatus;
  bool optio=false;
  final formval;
  final onNotification;

  Home({super.key,required this.tid,required this.norecord,required this.checkstatus,required this.tid_imput, required this.onNotification, required this.formval});

  @override
  Widget build(BuildContext context) {


    TextEditingController item_controller=TextEditingController();
    TextEditingController itemcategory_controller=TextEditingController();
    TextEditingController barcode_controller=TextEditingController();
    TextEditingController costprice_controller=TextEditingController();
    TextEditingController sellingprice_controller=TextEditingController();
    TextEditingController wholesaleprice_controller=TextEditingController();
    TextEditingController des_controller=TextEditingController();
    TextEditingController quantity_controller=TextEditingController();
    String photourl="";
    String? category="";
    List<String> section=["Home","Featured","Card one","Card two"];
    return Consumer<FireData>(
      builder: (BuildContext context, FireData value, Widget? child) {
        return NotificationListener<ScrollNotification>(
          onNotification: onNotification,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,8,8,60),
              child: Container(

                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          child: Form(
                            key: formval,
                            child: Column(
                              children: [
                                InputField(password:false,hintText: "Enter Item Name", controller: item_controller, textInputType: TextInputType.text,lableText: "Item Name",),
                                const SizedBox(height: 10,),
                                InputField(password:false,hintText: "Enter Cost Price", controller: costprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Price",),
                                const SizedBox(height: 10,),
                                InputField(password:false,hintText: "Enter Selling Price", controller: sellingprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Selling Price",),
                                const SizedBox(height: 10,),

                                InputField(password:false,hintText: "Wholesale  Price", controller: wholesaleprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Wholesale Price",),
                                const SizedBox(height: 10,),

                                InputField(password:false,hintText: "Enter Quantity", controller: quantity_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Quantity",),
                                const SizedBox(height: 10,),
                                // Container(
                                //   height: 50,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(10),
                                //     border: Border.all(width: 1,)
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: EditableText(
                                //         textWidthBasis: TextWidthBasis.longestLine,
                                //         enableSuggestions: true,
                                //         expands: true,
                                //         maxLines:null,
                                //         controller: des_controller, focusNode: FocusNode(),
                                //         style: const TextStyle(fontSize: 14,color: Colors.black),
                                //         cursorColor:Colors.black ,
                                //         backgroundCursorColor: Colors.black),
                                //   ),
                                // ),

                                 InputField(password:false,hintText: "Enter Item Description", controller: des_controller, textInputType: TextInputType.text,lableText: "Description",),
                                const SizedBox(height: 10,),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 400
                                  ),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: value.db.collection("category").snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        List<String> items=[];
                                        if(snapshot.hasData){
                                          items.clear();
                                          for (int i = 0; i < snapshot.data!.size; i++) {
                                            String name = snapshot.data!.docs[i]['name'];
                                            items.add(name);
                                          }
                                        }else {
                                        }

                                        return Container(
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child:DropdownSearch<String>(
                                            selectedItem: category,
                                            validator: (val){
                                              if(val!.isEmpty)
                                              {
                                                return "Select Category";
                                              }
                                            },
                                            autoValidateMode: AutovalidateMode.onUserInteraction,
                                            dropdownDecoratorProps:  DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                      color: Global.borderColor,
                                                      width: 1,
                                                    ),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  label: const Text("Item Category"),
                                                  hintText: "Item Category",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),

                                                )

                                            ),

                                            popupProps:const PopupProps.dialog(
                                              fit: FlexFit.loose,
                                              title: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Align(alignment: Alignment.center,child: Text("Search for Item Category",style: TextStyle(),)),
                                              ),
                                              showSearchBox: true,
                                            ),
                                            items: items,
                                            onChanged: (val) async {
                                              // value.selectedregion(val!);
                                              category=val!;
                                            },
                                            //selectedItem: items,
                                          )
                                          // DropdownButtonFormField(
                                          //   isExpanded: true,
                                          //   // validator: ValidationBuilder().minLength(3).build(),
                                          //   decoration: InputDecoration(
                                          //     hintText: "Select Item Category",
                                          //     labelText: "Item Category",
                                          //     //contentPadding: EdgeInsets.all(27),
                                          //     enabledBorder: OutlineInputBorder(
                                          //         borderRadius: BorderRadius.circular(10)),
                                          //     focusedBorder: OutlineInputBorder(
                                          //         borderSide: const BorderSide(
                                          //           color: Global.gradient2,
                                          //         ),
                                          //         borderRadius: BorderRadius.circular(10)),
                                          //   ),
                                          //   borderRadius:
                                          //   const BorderRadius.all(Radius.circular(10)),
                                          //   hint: const Text("Select Item Category"),
                                          //   elevation: 2,
                                          //   // Initial Value
                                          //   value: null,
                                          //   // Down Arrow Icon
                                          //   icon: const Icon(Icons.keyboard_arrow_down),
                                          //   // Array list of items
                                          //   items: items.map((String items) {
                                          //     return DropdownMenuItem(
                                          //       value:items,
                                          //       child: Text(items),
                                          //     );
                                          //   }).toList(),
                                          //
                                          //   onChanged: (text) {
                                          //     category=text!;
                                          //      print(category);
                                          //
                                          //
                                          //     //print( await value.countries());
                                          //   },
                                          // ),
                                        );
                                      }),
                                ),
                                const SizedBox(height: 10,),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 400
                                  ),
                                  child: DropdownButtonFormField(
                                    // validator: ValidationBuilder().minLength(3).build(),
                                    decoration: InputDecoration(
                                      hintText: "Display Sections",
                                      labelText: "Display Sections",
                                      //contentPadding: EdgeInsets.all(27),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Global.gradient2,
                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                    ),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                    hint: const Text("Select Item Category"),
                                    isExpanded: true,
                                    elevation: 2,
                                    // Initial Value
                                    value: null,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: section.map((String items) {
                                      return DropdownMenuItem(
                                        value:items,
                                        child: Text(items),
                                      );
                                    }).toList(),

                                    onChanged: (text) {
                                      category=text!;
                                      print(category);


                                      //print( await value.countries());
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                InputField(password:false,hintText: "Input/Scan Item Code", controller: tid_imput, textInputType: TextInputType.text,lableText: "Item Code",),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(onPressed:() async {
                                      // final progress=ProgressHUD.of(context);
                                      // progress?.show();
                                      // Future.delayed(Duration(seconds: 30),(){
                                      //   progress!.dismiss();
                                      //
                                      // });
                                      ImageSource source=ImageSource.gallery;
                                      await value.uploadImageToStorage(source );
                                      print(value.imageUrl);
                                      // print("Uploading..${value.imageUrl!}");
                                        var imageurl=value.imageUrl;
                                        ImageNetwork(image: imageurl, height: 200, width: 200);
                                     //  await value.newupload();
                                     // progress!.dismiss();
                                     //  image=fbaccount.imageUrl;
                                     //  if(image.isNotEmpty){
                                     //    // setState(() {
                                     //    //   imagestatus=true;
                                     //    //
                                     //    // });
                                     //  }

                                    }, icon: const Icon(Icons.image), label: const Text("Choose Image")),
                                    TextButton.icon(onPressed:() async {
                                      // final progress=ProgressHUD.of(context);
                                      // progress?.show();
                                      // Future.delayed(const Duration(seconds: 30),(){
                                      //   progress!.dismiss();
                                      // });
                                      ImageSource source=ImageSource.camera;
                                      await value.uploadImageToStorage(source);
                                      print(value.imageUrl);
                                      // print("Uploading..${value.imageUrl!}");
                                      // setState(() {
                                      //   imageurl=fbaccount.imageUrl;
                                      // });
                                      // await value.newupload();
                                      // progress!.dismiss();
                                      // image=fbaccount.imageUrl;
                                      // if(image.isNotEmpty){
                                      //   setState(() {
                                      //     imagestatus=true;
                                      //
                                      //   });
                                      // }

                                    }, icon: const Icon(Icons.camera_alt), label: const Text("Take Photo"))

                                  ],
                                ),

                                ElevatedButton(onPressed: ()async{
                                 if( value.validatrform(formval))
                                   {
                                     photourl=value.imageUrl;
                                     String item=item_controller.text.trim();
                                     String costprice=costprice_controller.text.trim();
                                     String sellingprice=sellingprice_controller.text.trim();
                                     String wholesaleprice=wholesaleprice_controller.text.trim();
                                     String quantity=quantity_controller.text.trim();
                                     String description=des_controller.text.trim();
                                     String code=tid_imput.text.trim();
                                     final regitem= await value.registeritem(item, sellingprice, costprice, wholesaleprice, quantity, description, code, category!,photourl);
                                     item_controller.clear();
                                     costprice_controller.clear();
                                     sellingprice_controller.clear();
                                     wholesaleprice_controller.clear();
                                     quantity_controller.clear();
                                     itemcategory_controller.clear();
                                     des_controller.clear();
                                     tid_imput.clear();
                                     quantity_controller.clear();
                                     photourl="";
                                   }

                                 // value.validatrform();

                                }, child: Text("Save Product"))


                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )

        );
      },
    );
  }
}
