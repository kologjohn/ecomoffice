
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecomoffice/dataase/FireaseData.dart';
import 'package:ecomoffice/forms/inputfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';



import '../../global.dart';
class Menus{
  final numformat = NumberFormat("#,##0.00", "en_US");

  final Stream<QuerySnapshot> usersStream = FireData().db.collection('sendmoney').snapshots();
  static PopupMenuItem buildPopupMenuItem(String title, IconData iconData,BuildContext context) {
    return PopupMenuItem(
      child:  GestureDetector(
        onTap: () {
          if(title=="Logout")
            {
              //  FirebaseAccounts().logout(context);
              // Navigator.pushNamedAndRemoveUntil(context, Routes.pinscreen, (Route<dynamic> route) => false);
            }
        },
        child: Row(
          children: [
            Icon(iconData, color: Colors.black,),
            Text(title),
          ],
        ),
      ),
    );
  }
  //modal box for diplay of infoinformation
  void imagemodal(context,String imagetxt,String key) {
    bool prog=false;
    showMaterialModalBottomSheet(backgroundColor:Colors.white,context: context, builder: (BuildContext bc) {
      //Widget image = Image.memory(byteImage);
      return ProgressHUD(
        child: Consumer<FireData>(builder: (BuildContext context,  value, Widget? child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Consumer<FireData>(
                builder: (context, data, child) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(),
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      color: Colors.white,

                    ),
                    // Define padding for the container.
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    // Create a Wrap widget to display the sheet contents.
                    child: SingleChildScrollView(
                      child: Wrap(
                        children:[
                          // Add a container with height to create some space
                          Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.grey,
                            child: Row(
                              children: [
                                ElevatedButton(onPressed: () async {
                                  prog=true;
                                  final progress=ProgressHUD.of(context);
                                  progress!.show();
                                  Future.delayed(const Duration(seconds: 30),(){
                                    progress.dismiss();
                                  });
                                 // await value.updateImage(key);
                                  prog=true;
                                  if(value.imageUrl.isNotEmpty)
                                  {
                                    prog=false;
                                    progress.dismiss();
                                    imagetxt=value.imageUrl;
                                    SnackBar snackbar=const SnackBar(content: Text("Payment Evidence Uploaded Successfully"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  }
                                }, child: const Text("Upload New Payment Evidence")),
                                const SizedBox(width: 10,),
                                GestureDetector(onTap:(){
                                  Navigator.pop(context);
                                },child: const Icon(Icons.close,color: Colors.blue,))


                              ],
                            ),
                          ),
                               Image.network(imagetxt,fit: BoxFit.contain,)

                          // Add a row widget to display buttons for closing and reading more.
                        ],
                      ),
                    ),


                  );
                },
              ),
            ),
          );
        },
        ),
      );

    }
    );
  }


  editItems(context,String item,String barcode,String sellingprice,String costprice,String wholesaleprice,String description,String category,String quantity,String photo,String key) async {


    TextEditingController item_controller=TextEditingController();
    TextEditingController itemcategory_controller=TextEditingController();
    TextEditingController barcode_controller=TextEditingController();
    TextEditingController costprice_controller=TextEditingController();
    TextEditingController sellingprice_controller=TextEditingController();
    TextEditingController wholesaleprice_controller=TextEditingController();
    TextEditingController des_controller=TextEditingController();
    TextEditingController quantity_controller=TextEditingController();


    item_controller.text=item;
    barcode_controller.text=barcode;
    costprice_controller.text=costprice;
    sellingprice_controller.text=sellingprice;
    wholesaleprice_controller.text=wholesaleprice;
    des_controller.text=description;
    quantity_controller.text=quantity;
     List<String> items = [];
    final categoryform = GlobalKey<FormState>();
    bool validate1() {
      return categoryform.currentState!.validate();
    }

    // Show a modal bottom sheet with the specified context and builder method.
    showMaterialModalBottomSheet(
        enableDrag: true,
        //backgroundColor:Colors.black,
        context: context, builder: (BuildContext bc) {
          return Builder(
              builder: (context) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 800
                  ),
                  child: Container(
                    height: 600,
                    //height: double.infinity,
                    // Define padding for the container.
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        )
                    ),
                    // Create a Wrap widget to display the sheet contents.
                    child: SingleChildScrollView(
                      child: Container(
                        // color: Global.backgroundColor,
                          padding: const EdgeInsets.all(5),
                          child: Form(
                            key: categoryform,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),

                                InputField(password:false,hintText: "Item Name", controller: item_controller, textInputType: TextInputType.name,lableText: "Item",),

                                const SizedBox(height: 10,),

                                InputField(password:false,hintText: "Enter Cost Price", controller: costprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Price",),
                                const SizedBox(height: 10,),
                                InputField(password:false,hintText: "Enter Selling Price", controller: sellingprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Selling Price",),
                                const SizedBox(height: 10,),

                                InputField(password:false,hintText: "Wholesale  Price", controller: wholesaleprice_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Wholesale Price",),
                                const SizedBox(height: 10,),

                                InputField(password:false,hintText: "Enter Quantity", controller: quantity_controller, textInputType: const TextInputType.numberWithOptions(decimal: true),lableText: "Quantity",),
                                const SizedBox(height: 10,),
                                InputField(password:false,hintText: "Enter Item Description", controller: des_controller, textInputType: TextInputType.text,lableText: "Description",),
                                const SizedBox(height: 20,),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream:   FireData().db.collection('category').snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot> snapshot) {
                                        // List of items in our dropdown menu
                                        //  print(FirebaseFirestore.instance.disableNetwork().);
                                        if(snapshot.hasData){
                                          items.clear();
                                          for (int i = 0; i < snapshot.data!.size; i++) {
                                            String name = snapshot.data!.docs[i]['name'];
                                            items.add(name);
                                          }
                                          print(items);

                                        }
                                        else
                                          {
                                            return const Text("waitig...");
                                          }

                                        return ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxWidth: 400
                                          ),
                                          child: DropdownSearch<String>(
                                            selectedItem: category,
                                            validator: (val){
                                              if(category.isEmpty)
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
                                                  label: const Text("Region"),
                                                  hintText: "Region",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),

                                                )

                                            ),

                                            popupProps:const PopupProps.dialog(
                                              fit: FlexFit.loose,
                                              title: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Align(alignment: Alignment.center,child: Text("Search for Region/Constituency",style: TextStyle(),)),
                                              ),
                                              showSearchBox: true,
                                            ),
                                            items: items,
                                            onChanged: (val) async {
                                             // value.selectedregion(val!);
                                              category=val!;
                                            },
                                            //selectedItem: items,
                                          ),
                                        );

                                        //   ConstrainedBox(
                                        //   constraints: BoxConstraints(
                                        //     maxWidth: 400
                                        //   ),
                                        //   child: Container(
                                        //     decoration: const BoxDecoration(
                                        //         borderRadius:
                                        //         BorderRadius.all(Radius.circular(10)),
                                        //         shape: BoxShape.rectangle),
                                        //     child: DropdownButtonFormField(
                                        //      // value: category,
                                        //       // validator: ValidationBuilder().minLength(3).build(),
                                        //       decoration: InputDecoration(
                                        //         hintText: "Select Item Category",
                                        //         labelText: "Item Category",
                                        //         //contentPadding: EdgeInsets.all(27),
                                        //         enabledBorder: OutlineInputBorder(
                                        //             borderSide: const BorderSide(
                                        //               color: Global.borderColor,
                                        //               width: 3,
                                        //             ),
                                        //             borderRadius: BorderRadius.circular(10)),
                                        //         focusedBorder: OutlineInputBorder(
                                        //             borderSide: const BorderSide(
                                        //               color: Global.gradient2,
                                        //               width: 3,
                                        //             ),
                                        //             borderRadius: BorderRadius.circular(10)),
                                        //       ),
                                        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        //       hint: const Text("Select Item Category"),
                                        //       isExpanded: true,
                                        //       elevation: 2,
                                        //       icon: const Icon(Icons.keyboard_arrow_down),
                                        //       // Array list of items
                                        //       items: items.map((String item) {
                                        //         return DropdownMenuItem(
                                        //           value: item,
                                        //           child: Text(item),
                                        //         );
                                        //       }).toList(),
                                        //       onChanged: (text) {
                                        //         category=text!;
                                        //         //  print(text);
                                        //         //print( await value.countries());
                                        //       },
                                        //     ),
                                        //   ),
                                        // );
                                      }),
                                ),
                                const SizedBox(height: 10,),
                                //amount you pay

                                //Amount Recipient get

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                      gradient:  const LinearGradient(
                                        colors: [
                                          Colors.green,
                                          Colors.greenAccent,
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(validate1())
                                      {
                                         item=item_controller.text.trim();
                                         costprice=costprice_controller.text.trim();
                                         sellingprice=sellingprice_controller.text.trim();
                                         wholesaleprice=wholesaleprice_controller.text.trim();
                                         quantity=quantity_controller.text.trim();
                                         description=des_controller.text.trim();
                                         print(category);
                                         await FireData().updateitem(item, sellingprice, costprice, wholesaleprice, quantity, description, key, category,photo);
                                          Navigator.of(context).pop();
                                          SnackBar snackBar= SnackBar(content: Text("$item updated Successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,);
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);



                                      }


                                      // print(name.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(395, 55),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text(
                                      //'Sign in',
                                      'UPDATE RECORD',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                                //Your currency

                              ],
                            ),
                          )),
                    ),
                  ),
                );
              }
          );


    });
  }
  editCategory(context,String name,String key) async {
    TextEditingController name_controller=TextEditingController();
    final _moneyform1 = GlobalKey<FormState>();
    bool validate1() {
      return _moneyform1.currentState!.validate();
    }
    name_controller.text=name;
    showMaterialModalBottomSheet(
        enableDrag: true,
        //backgroundColor:Colors.black,
        context: context, builder: (BuildContext bc) {



          return Builder(
              builder: (context) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 800
                  ),
                  child: Container(
                    height: 600,
                    //height: double.infinity,
                    // Define padding for the container.
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        )
                    ),
                    // Create a Wrap widget to display the sheet contents.
                    child: SingleChildScrollView(
                      child: Container(
                        // color: Global.backgroundColor,
                          padding: const EdgeInsets.all(5),
                          child: Form(
                            key: _moneyform1,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(

                                  keyboardType: TextInputType.text,
                                  controller: name_controller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Item Name",
                                      labelText: "Item"
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                //amount you pay

                                //Amount Recipient get

                                Container(
                                  decoration: BoxDecoration(
                                   color: Colors.green,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(validate1())
                                      {
                                        // final progress=ProgressHUD.of(context);
                                        // progress!.show();

                                        // await value.momoaccount(email!, network, name_txt,phone_txt);
                                        print(key);
                                        await FireData().Categoryupdate(name_controller.text.trim(), key);
                                          Navigator.of(context).pop();
                                       // progress!.dismiss();
                                        //if(value.errorMsgs.isEmpty)
                                        {

                                          SnackBar snackBar= SnackBar(content: Text("$name updated Successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,);
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                        // else
                                        // {
                                        //   SnackBar snackBar= SnackBar(content: Text(value.errorMsgs,style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,);
                                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        // }

                                      }


                                      // print(name.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(395, 55),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text(
                                      //'Sign in',
                                      'Save Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                                //Your currency

                              ],
                            ),
                          )),
                    ),
                  ),
                );
              }
          );


    });
  }
  Addcategory(context) async {
    TextEditingController name_controller=TextEditingController();
    final _moneyform1 = GlobalKey<FormState>();
    bool validate1() {
      return _moneyform1.currentState!.validate();
    }
    showMaterialModalBottomSheet(
        enableDrag: true,
        //backgroundColor:Colors.black,
        context: context, builder: (BuildContext bc) {



          return Builder(
              builder: (context) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxWidth: 800
                  ),
                  child: Container(
                    height: 600,
                    //height: double.infinity,
                    // Define padding for the container.
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        )
                    ),
                    // Create a Wrap widget to display the sheet contents.
                    child: SingleChildScrollView(
                      child: Container(
                        // color: Global.backgroundColor,
                          padding: const EdgeInsets.all(5),
                          child: Form(
                            key: _moneyform1,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(

                                  keyboardType: TextInputType.text,
                                  validator: (text){
                                    if(text!.isEmpty){
                                      return "Input Category Name";
                                    }
                                  },
                                  controller: name_controller,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Input Category Name",
                                      labelText: "Item Category"
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                //amount you pay

                                //Amount Recipient get

                                Container(
                                  decoration: BoxDecoration(
                                   color: Colors.green,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(validate1())
                                      {
                                        await FireData().Category(name_controller.text.trim(),"null");
                                        Navigator.of(context).pop();
                                        SnackBar snackBar= SnackBar(content: Text("${name_controller.text} updated Successfully",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,);
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }


                                      // print(name.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(395, 55),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text(
                                      //'Sign in',
                                      'Save Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                                //Your currency

                              ],
                            ),
                          )),
                    ),
                  ),
                );
              }
          );


    });
  }

}
