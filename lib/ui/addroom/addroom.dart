import 'package:chatroom/model/Category.dart';
import 'package:chatroom/ui/addroom/AddRoomNavigator.dart';
import 'package:chatroom/ui/addroom/Addroomviewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addroom extends StatefulWidget{
  static const String routeName='addroom';

  @override
  State<Addroom> createState() => _AddroomState();
}

class _AddroomState extends State<Addroom> implements AddRoomNavigator{
  AddRoomViewModel viewModel=AddRoomViewModel();
  String title='';
  String description='';
  Category? selecteditem;
  var Categorylist=Category.getCategory();
  var formkey=GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
    viewModel.navigator=this;
  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Add Room'),
              centerTitle: true,
            ),

            body:Container(
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 52),
              padding:EdgeInsets.all(12) ,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
boxShadow: [
  BoxShadow(
    color:Colors.grey,
    spreadRadius: 5,
    blurRadius: 7,
  ),
],
              ),

              child: Form(
                child: Column(
                  children: [
                    Text('Create New Room',style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),),
                    SizedBox(height: 16,),
                    Image.asset('assets/images/group.png'),
                    SizedBox(height: 16,),
                    TextFormField(
                      onChanged: (text){
                        title=text;
                      },
                      validator:(text){
                        if(text== null || text.trim().isEmpty )
                          {
                            return 'please enter room title';
                          }
                        return null;
                      } ,
                      decoration: InputDecoration(
                        hintText: 'Enter room title'
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                     
                      children: [
                        Expanded(
                          child: DropdownButton<Category>(
                            value: selecteditem,
                              items: Categorylist.map((category) =>
                              DropdownMenuItem<Category>(
                                value: category,
                                  child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text(category.title),
                            Image.asset(category.image)
                          ],))).toList(), onChanged: (newcategory){
                              if(newcategory==null) return;
                              selecteditem=newcategory;
                              setState(() {

                              });
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      onChanged: (text){
                        description=text;
                      },
                      validator:(text){
                        if(text== null || text.trim().isEmpty )
                        {
                          return 'please enter room description';
                        }
                        return null;
                      } ,
                      decoration: InputDecoration(
                          hintText: 'Enter room description'
                      ),
                      maxLines: 4,
                    ),
                    Spacer(flex: 2,),
                    Column(
                      crossAxisAlignment:  CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(onPressed: (){
                          validateform();
                        },
                            child: Text('Add room')),
                      ],
                    ),
                    Spacer(flex: 1,),
                    
                  ],
                ),
              ),
            ) ,
          ),


        ],
      ),
    );
  }

  void validateform() {
    if(formkey.currentState?.validate()==true){
      //add room
    }
  }
}