import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'api.dart';
String read_file_data;
get colomun => null;
void home() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'المبيعات',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'المبيعات'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  static final DateTime now1 = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now1);
  bool first = true;
  double claculationOfSales=0;
  int numberOfPerson=0;
  information user = new information();
  final _scrollController = ScrollController();
  String data="";
  String formattedDate = DateFormat('kk:mm').format(now1);
  var rows = <Row>[Row(children: [
    Expanded(flex: 2, child:
    Text("", textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),
    ),]),
    Row(children: [
      Expanded(flex: 2, child:
      Text("", textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),
      ),]),
    Row(children: [
      Expanded(flex: 2, child:
      Text("", textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),
      ),]),
    Row(children: [
      Expanded(flex: 2, child:
      Text("", textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),
      ),]),
    Row(children: [
      Expanded(flex: 2, child:
      Text("اضغط على أيقونة التحميل لتنزيل المعلومات", textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontFamily: "Amiri",fontSize: 25),),
      ),]),




  ];





  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays ([]);
    claculationOfSales=100;
    numberOfPerson=10;
    user.vertics="عمان";
    String data_for_write="";
    for(int c=0;c<100;c++)
    {
      user.avarg=(claculationOfSales/numberOfPerson).toStringAsFixed(2);
      data_for_write=data_for_write+ user.vertics+","+claculationOfSales.toString()+","+numberOfPerson.toString()+","+user.avarg+"\n";
      numberOfPerson+=10;
      claculationOfSales+=100;
    }



    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,style: TextStyle(fontFamily: "Amiri",fontSize: 25),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: (){

            Dialog errorDialog = Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), //this right here
              child: Container(
                  height: 190,
                  width: 300.0,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      CircleAvatar(radius: 30,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      ),
                      Text("الخروج من التطبيق",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'Amiri',fontSize: 16),),
                      SizedBox(height: 10,),
                      Text("هل أنت متأكد من الخروج من التطبيق ؟",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontFamily: 'Amiri'),),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(flex: 1,child: SizedBox(
                          )),
                          Expanded(flex: 3,child:
                          TextButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((state) => Colors.blue)),onPressed: (){
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                          },child: Text(" البقاء",style: TextStyle(color: Colors.white,fontFamily: "Amiri"),),),

                          ),
                          Expanded(flex: 2,child: SizedBox(
                          )),
                          Expanded(flex: 3,child:
                          TextButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((state) => Colors.blue)),onPressed: (){
                            SystemNavigator.pop();
                            exit(0);
                          },child: Text(" خروج",style: TextStyle(color: Colors.white,fontFamily: "Amiri"),),),

                          ),
                          Expanded(flex: 1,child: SizedBox(
                          )),

                        ],
                      )
                    ],
                  )

              ),
            );
            showDialog(context: context, builder: (BuildContext context) => errorDialog);}
          ,
        ),
        actions: [
          IconButton(onPressed: (){
            ProgressDialog progress= ProgressDialog(context,type: ProgressDialogType.Normal);
            progress.update(message: "الرجاء الانتظار",);
            progress.show();
            Api().getTeams("").whenComplete(() {
              print(read_file_data);
              progress.hide();
              setState(() {
                user.claculateOfSales = 0;
                user.numberOfPerson = 0;
                claculationOfSales = 0;
                numberOfPerson = 0;
                user.claculateOfSales = 0;
                user.numberOfPerson = 0;
                user.avarg = "0";
                rows.clear();
                rows.add( Row( children: [

                  Expanded(flex: 2,child:
                  Column(children:[
                    Text('قيمة السلة',style: TextStyle(color: Colors.black,fontFamily: "Amiri",fontSize: 15,),)
                  ]),
                  ),
                  Expanded(flex: 3,child:
                  Column(children:[
                    Text('عدد الزبائن',style: TextStyle(color: Colors.black,fontFamily: "Amiri",fontSize: 15),)
                  ]),
                  ),
                  Expanded(flex: 3,child:
                  Column(
                      children:[
                        Text('مجموع المبيعات',style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: "Amiri"),)
                      ]),
                  ),
                  Expanded(flex: 2,child:
                  Column(children:[
                    Text('الفرع',style: TextStyle(color: Colors.black,fontFamily: "Amiri",fontSize: 15),)
                  ]),
                  ),
                ]),);
                data = data_for_write;
                List<String> data1 = data.toString().split("\n");
                for (var r = 0; r < data1.length-2; r++) {
                  List<String>data2 = data1.elementAt(r).split(",");
                  double d = (double.parse(data2.elementAt(1))) /
                      (int.parse(data2.elementAt(2)));
                  rows.add(Row(children: [
                    Expanded(flex: 2, child:
                    Text(d.toStringAsFixed(2), textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),
                    ),
                    Expanded(flex: 3, child:
                    Text(data2.elementAt(2), textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),

                    ),
                    Expanded(flex: 3, child:
                    Text(data2.elementAt(1), textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),

                    ),
                    Expanded(flex: 2, child:
                    Text(data2.elementAt(0), textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontFamily: "Amiri"),),

                    ),
                  ]
                  )
                  );
                  user.claculateOfSales = double.parse(data2.elementAt(1));
                  user.numberOfPerson = int.parse(data2.elementAt(2));
                  claculationOfSales = claculationOfSales + user.claculateOfSales;
                  numberOfPerson = numberOfPerson + user.numberOfPerson;
                  user.claculateOfSales = user.claculateOfSales + 100;
                  user.numberOfPerson = user.numberOfPerson + 10;
                  user.avarg =
                      (user.claculateOfSales / user.numberOfPerson).toStringAsFixed(2);
                }

                print("iam in set");
              });
              });



          }, icon: Icon(Icons.download_sharp))
        ],
      ),
      backgroundColor: Colors.blue,
      body:Center(

        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child:
            Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2,child:
                    Text( DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri",fontSize: 18)),
                    ),
                    Expanded(flex: 2,child:
                    Text("  :الوقت",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri1",fontSize: 30),),

                    ),
                    Expanded(flex: 2,child:
                    Text((now1.day.toString()+"/"+now1.month.toString()+"/"+now1.year.toString()),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri",fontSize: 18)),

                    ),
                    Expanded(flex: 2,child:
                    Text( "   :التاريخ",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri1",fontSize: 30),),

                    ),

                  ],
                )
            ),
          ),

          Expanded(
            flex: 7,
            child:
            Container(
              color: Colors.blue[100],
              height: 320,
              margin: EdgeInsets.all(10),
              child:
              Scrollbar(
                  isAlwaysShown: true,
                  controller:_scrollController ,
                  child:SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    child:
                    Column(
                      children: rows,

                    ),
                  )

              ),

            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: FractionalOffset.bottomRight,
              child: MaterialButton(
                  onPressed: null,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3,child:
                      Column(
                        children: [
                          Text("قيمة السلة",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri1",fontSize: 25),),
                          Text((claculationOfSales/numberOfPerson).toStringAsFixed(3),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri",fontSize: 25),),
                        ],
                      ),
                      ),
                      Expanded(flex: 3,child:
                      Column(
                        children: [
                          Text("عدد الزبائن",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri1",fontSize: 25),),
                          Text(numberOfPerson.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri",fontSize: 25),),
                        ],
                      ),
                      ),
                      Expanded(
                        flex: 4,child:
                      Column(
                        children: [
                          Text("مجموع المبيعات",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri1",fontSize: 25),),
                          Text(claculationOfSales.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: "Amiri",fontSize: 25),),
                        ],
                      ),
                      ),


                    ],
                  )
              ),
            ),
          ),
        ]
        ),
      ),

      // Container (
      //     width: double.infinity,
      //     height: 48.0,
      //   child: Column(
      //     children: [
      //              Row(
      //       mainAxisAlignment: MainAxisAlignment.center ,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Text(formattedDate,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
      //                 Text("الوقت    ",textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
      //                 SizedBox(width: 20),
      //                 Text(formatted,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
      //                 Text("التاريخ  ",textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
      //               ],
      //             ),
      //
      //
      //     ] ,
      //   )
      // ),

    );

  }


}
class information {
  String vertics;
  double claculateOfSales;
  int numberOfPerson;
  String avarg;

  information({this.vertics, this.claculateOfSales, this.numberOfPerson,this.avarg});

  factory information.fromJson(Map<String, dynamic> json) {
    return information(
      vertics: json['الفرع'],
      claculateOfSales: json['مجموع المبيعات'],
      numberOfPerson: json['عدد الزبائن'],
      avarg: json['السلة'],
    );
  }
}
// _write(String text) async {
//   final Directory directory = await getExternalStorageDirectory();
//   final File file = File('${directory.path}/flutterData.txt');
//   await file.writeAsString(text);
// }
// Future<String> _read() async {
//   String text="";
//   try {
//     final Directory directory = await getExternalStorageDirectory();
//     print(directory.path);
//     final File file = File('${directory.path}/flutterData.txt');
//     text = await file.readAsString();
//     read_file_data=text;
//     print(read_file_data);
//   } catch (e) {
//     print("Couldn't read file");
//   }
//   return text;
// }

