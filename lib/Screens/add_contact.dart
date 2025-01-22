

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './home_screen.dart';

class AddContact extends StatefulWidget{
  Function(String email,String alias) change;

  AddContact({required this.change});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController alias = new TextEditingController();
  TextEditingController email = new TextEditingController();

  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add SOS",
                        style: GoogleFonts.poppins(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.help))
                    ],
                  ),

                ),
                Form(key:_formKey, child: Column(
                    children:
                    [Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: email,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                        validator: (value){
                          if(value!.isEmpty || value.length == 0){
                            return "Email Cannot be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Alias",

                        ),
                      ),
                    ),

                      Container(
                          margin: EdgeInsets.all(10),

                          child: TextFormField(
                            controller: alias,
                            validator: (value){
                              if(value!.isEmpty || value.length == 0){
                                return "Field Cannot be empty";
                              }
                              return null;
                            },
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),

                          )),]
                )),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      Navigator.pop(context);
                    }
                  }, child: const Text("Yeh bachayega mujha"),style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      textStyle: GoogleFonts.montserrat()
                  ),),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromRGBO(0, 232, 152, 1),
                  ),

                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }, icon: Icon(Icons.home_filled)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
                      IconButton(onPressed: (){

                      }, icon: const Icon(Icons.graphic_eq)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}